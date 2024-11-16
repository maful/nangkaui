# frozen_string_literal: true

module NangkaUI
  class TabsTrigger < TabsBase
    style do
      base { "inline-flex items-center justify-center whitespace-nowrap rounded-sm px-3 py-1.5 text-sm font-medium ring-offset-background transition-all focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50 data-[state=active]:bg-background data-[state=active]:text-foreground data-[state=active]:shadow-sm" }
    end

    def initialize(**system_arguments)
      trigger_value = system_arguments.delete(:value)
      system_arguments[:type] = "button"
      system_arguments[:role] = "tab"
      system_arguments[:tabindex] = "0"
      system_arguments[:id] = build_trigger_id(trigger_value)
      system_arguments[:aria_controls] = build_content_id(trigger_value)
      system_arguments["data-action"] = "click->nangkaui--tabs#activate"

      super
    end

    def view_template(&content)
      button(class: tw_merge(style, classes), **system_arguments, &content)
    end
  end
end
