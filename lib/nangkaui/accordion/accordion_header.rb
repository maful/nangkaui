# frozen_string_literal: true

module NangkaUI
  class AccordionHeader < Base
    include Helper

    style do
      base { "flex flex-1 items-center justify-between py-4 font-medium transition-all hover:underline [&[data-state=open]>svg]:rotate-180" }
    end

    def initialize(**system_arguments)
      value = system_arguments.delete(:value)
      system_arguments[:type] = "button"
      system_arguments[:aria_controls] = build_content_id(value, prefix: "accordion")
      system_arguments[:aria_expanded] = "false"
      system_arguments[:data_state] = "closed"
      system_arguments[:id] = build_trigger_id(value, prefix: "accordion")
      system_arguments[:data_action] = "click->nangkaui--accordion#toggle"

      super
    end

    def view_template(&block)
      h3(class: "flex") do
        button(class: tw_merge(style, classes), **system_arguments) do
          block.call
          icon
        end
      end
    end

    private

    def icon
      svg(
        xmlns: "http://www.w3.org/2000/svg",
        width: "24",
        height: "24",
        viewbox: "0 0 24 24",
        fill: "none",
        stroke: "currentColor",
        stroke_width: "2",
        stroke_linecap: "round",
        stroke_linejoin: "round",
        class: "h-4 w-4 shrink-0 transition-transform duration-200",
      ) { |s| s.path(d: "m6 9 6 6 6-6") }
    end
  end
end
