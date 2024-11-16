# frozen_string_literal: true

module NangkaUI
  class TabsContent < TabsBase
    style do
      base { "mt-2 ring-offset-background focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2" }
    end

    def initialize(**system_arguments)
      trigger_value = system_arguments.delete(:value)
      system_arguments[:role] = "tabpanel"
      system_arguments[:tabindex] = "0"
      system_arguments[:hidden] = true
      system_arguments[:id] = build_content_id(trigger_value)
      system_arguments[:aria_labelledby] = build_trigger_id(trigger_value)

      super
    end

    def view_template(&content)
      div(class: tw_merge(style, classes), **system_arguments, &content)
    end
  end
end
