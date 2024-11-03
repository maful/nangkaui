# frozen_string_literal: true

module NangkaUI
  class Base < Phlex::HTML
    include StyleVariants

    attr_reader :system_arguments

    def initialize(**system_arguments)
      @system_arguments = system_arguments
    end

    if defined?(Rails) && Rails.env.development?
      def before_template
        comment { "Before #{self.class.name}" }
        super
      end
    end
  end
end
