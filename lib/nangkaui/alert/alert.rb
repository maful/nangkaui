# frozen_string_literal: true

module NangkaUI
  class Alert < Base
    style do
      base { "relative w-full rounded-lg border p-4 [&>svg~*]:pl-7 [&>svg+div]:translate-y-[-3px] [&>svg]:absolute [&>svg]:left-4 [&>svg]:top-4 [&>svg]:text-foreground" }
      variants do
        variant do
          default { "bg-background text-foreground" }
          destructive { "border-destructive/50 text-destructive dark:border-destructive [&>svg]:text-destructive" }
        end
      end
      defaults { { variant: :default } }
    end

    attr_reader :variant

    def initialize(variant: :default, **system_arguments)
      @variant = variant
      system_arguments["role"] = "alert"
      super(**system_arguments)
    end

    def view_template(&content)
      div(class: style(variant:), **system_arguments, &content)
    end

    def with_title(**attrs, &content)
      h5(class: "mb-1 font-medium leading-none tracking-tight", **attrs, &content)
    end

    def with_description(**attrs, &content)
      div(class: "text-sm [&_p]:leading-relaxed", **attrs, &content)
    end
  end
end
