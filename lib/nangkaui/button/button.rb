# frozen_string_literal: true

module NangkaUI
  class Button < Base
    style do
      base { "inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-md text-sm font-medium ring-offset-background transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50 [&_svg]:pointer-events-none [&_svg]:size-4 [&_svg]:shrink-0" }
      variants do
        variant do
          default { "bg-primary text-primary-foreground hover:bg-primary/90" }
          destructive { "bg-destructive text-destructive-foreground hover:bg-destructive/90" }
          outline { "border border-input bg-background hover:bg-accent hover:text-accent-foreground" }
          secondary { "bg-secondary text-secondary-foreground hover:bg-secondary/80" }
          ghost { "hover:bg-accent hover:text-accent-foreground" }
          link { "text-primary underline-offset-4 hover:underline" }
        end
        size do
          default { "h-10 px-4 py-2" }
          sm { "h-9 rounded-md px-3" }
          lg { "h-11 rounded-md px-8" }
          icon { "h-10 w-10" }
        end
      end
      defaults { { variant: :default, size: :default } }
    end

    attr_reader :variant, :size

    def initialize(variant: :default, size: :default, **system_arguments)
      @variant = variant
      @size = size
      super(**system_arguments)
    end

    def view_template(&content)
      button(class: style(variant:, size:), **system_arguments, &content)
    end
  end
end