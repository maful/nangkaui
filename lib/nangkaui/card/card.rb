# frozen_string_literal: true

module NangkaUI
  class Card < Base
    def view_template(&content)
      div(class: "rounded-lg border bg-card text-card-foreground shadow-sm", **system_arguments, &content)
    end

    def header(&content)
      render(CardHeader.new, &content)
    end

    def content(&content)
      div(class: "p-6 pt-0", &content)
    end

    def footer(&content)
      div(class: "flex items-center p-6 pt-0", &content)
    end
  end
end
