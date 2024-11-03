# frozen_string_literal: true

require "active_support/core_ext/object/blank"
require "active_support/inflector/methods"

module NangkaUI
  # modified version of view_component-contrib code
  # https://github.com/palkan/view_component-contrib/blob/master/lib/view_component_contrib/style_variants.rb
  module StyleVariants
    class VariantBuilder
      attr_reader :unwrap_blocks

      def initialize(unwrap_blocks = true)
        @unwrap_blocks = unwrap_blocks
        @variants = {}
      end

      def build(&block)
        instance_eval(&block)
        @variants
      end

      def respond_to_missing?(name, include_private = false)
        true
      end

      def method_missing(name, &block)
        return super unless block_given?

        @variants[name] = if unwrap_blocks
          VariantBuilder.new(false).build(&block)
        else
          block
        end
      end
    end

    class StyleSet
      def initialize(&init_block)
        @base_block = nil
        @defaults = {}
        @variants = {}
        @compounds = {}

        instance_eval(&init_block) if init_block
      end

      def base(&block)
        @base_block = block
      end

      def defaults(&block)
        @defaults = block.call.freeze
      end

      def variants(&block)
        @variants = VariantBuilder.new(true).build(&block)
      end

      def compound(**variants, &block)
        @compounds[variants] = block
      end

      def compile(**variants)
        acc = Array(@base_block&.call || [])

        config = @defaults.merge(variants.compact)

        config.each do |variant, value|
          value = cast_value(value)
          variant = @variants.dig(variant, value) || next
          styles = variant.is_a?(::Proc) ? variant.call(**config) : variant
          acc.concat(Array(styles))
        end

        @compounds.each do |compound, value|
          next unless compound.all? { |k, v| config[k] == v }

          styles = value.is_a?(::Proc) ? value.call(**config) : value
          acc.concat(Array(styles))
        end

        acc
      end

      def dup
        copy = super
        copy.instance_variable_set(:@defaults, @defaults.dup)
        copy.instance_variable_set(:@variants, @variants.dup)
        copy.instance_variable_set(:@compounds, @compounds.dup)
        copy
      end

      private

      def cast_value(val)
        case val
        when true then :yes
        when false then :no
        else
          val
        end
      end
    end

    class StyleConfig
      DEFAULT_POST_PROCESSOR = ->(compiled) { compiled.join(" ") }

      attr_reader :postprocessor

      def initialize
        @styles = {}
        @postprocessor = DEFAULT_POST_PROCESSOR
      end

      def define(name, &block)
        styles[name] = StyleSet.new(&block)
      end

      def compile(name, **variants)
        styles[name]&.compile(**variants).then do |compiled|
          next unless compiled

          postprocess(compiled)
        end
      end

      # Allow defining a custom postprocessor
      def postprocess_with(callable = nil, &block)
        @postprocessor = callable || block
      end

      def dup
        copy = super
        copy.instance_variable_set(:@styles, @styles.dup)
        copy
      end

      private

      attr_reader :styles

      def postprocess(compiled) = postprocessor.call(compiled)
    end

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      # Returns the name of the default style set based on the class name:
      #  MyComponent::Component => my_component
      #  Namespaced::MyComponent => my_component
      def default_style_name
        module_name = ActiveSupport::Inflector.demodulize(name).sub(/(::Component|Component)$/, "")
        @default_style_name ||= ActiveSupport::Inflector.underscore(module_name).presence || "component"
      end

      def style(name = default_style_name, &block)
        style_config.define(name.to_sym, &block)
      end

      def style_config
        @style_config ||= if superclass.respond_to?(:style_config)
          superclass.style_config.dup
        else
          StyleConfig.new
        end
      end
    end

    def style(name = self.class.default_style_name, **variants)
      self.class.style_config.compile(name.to_sym, **variants)
    end
  end
end
