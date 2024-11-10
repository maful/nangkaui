# frozen_string_literal: true

module NangkaUI
  class Base < Phlex::HTML
    include StyleVariants

    attr_reader :system_arguments

    def initialize(**system_arguments)
      @system_arguments = system_arguments
    end

    style_config.postprocess_with do |classes|
      TailwindMerge::Merger.new.merge(classes.join(" "))
    end

    def tw_merge(*classes)
      tw_merger.merge(classes.join(" "))
    end

    if defined?(Rails) && Rails.env.development?
      def before_template
        comment { "Before #{self.class.name}" }
        super
      end
    end

    private

    def tw_merger
      @_tw_merger ||= TailwindMerge::Merger.new
    end
  end
end
