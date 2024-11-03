# frozen_string_literal: true

module NangkaUI
  class Badge < Base
    style do
      base { "inline-flex items-center rounded-full border px-2.5 py-0.5 text-xs font-semibold transition-colors focus:outline-none focus:ring-2 focus:ring-ring focus:ring-offset-2" }
      variants do
        variant do
          default { "border-transparent bg-primary text-primary-foreground hover:bg-primary/80" }
          seconday { "border-transparent bg-secondary text-secondary-foreground hover:bg-secondary/80" }
          outline { "text-foreground" }
          destructive { "border-transparent bg-destructive text-destructive-foreground hover:bg-destructive/80" }
        end
      end
      defaults { { variant: :default } }
    end

    attr_reader :variant

    def initialize(variant: :default, **system_arguments)
      @variant = variant
      super(**system_arguments)
    end

    def view_template(&content)
      div(class: style(variant:), **system_arguments, &content)
    end
  end
end
