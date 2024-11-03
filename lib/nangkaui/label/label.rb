# frozen_string_literal: true

module NangkaUI
  class Label < Base
    style do
      base { "text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70" }
    end

    def view_template(&content)
      label(class: style, **system_arguments, &content)
    end
  end
end
