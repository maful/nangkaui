# frozen_string_literal: true

module NangkaUI
  class AccordionContent < Base
    include Helper

    style do
      base { "overflow-hidden text-sm transition-all data-[state=closed]:animate-accordion-up data-[state=open]:animate-accordion-down" }
    end

    def initialize(**system_arguments)
      value = system_arguments.delete(:value)
      system_arguments[:data_state] = "closed"
      system_arguments[:id] = build_content_id(value, prefix: "accordion")
      system_arguments[:role] = "region"
      system_arguments[:aria_labelledby] = build_trigger_id(value, prefix: "accordion")
      system_arguments[:hidden] = true

      super
    end

    def view_template(&block)
      div(class: style, **system_arguments) do
        div(class: tw_merge("pb-4 pt-0", classes), &block)
      end
    end
  end
end
