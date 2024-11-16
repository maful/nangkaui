# frozen_string_literal: true

module NangkaUI
  class Skeleton < Base
    def view_template(&content)
      div(class: tw_merge("animate-pulse rounded-md bg-muted", classes), **system_arguments, &content)
    end
  end
end
