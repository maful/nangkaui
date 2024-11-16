# frozen_string_literal: true

module NangkaUI
  class TabsBase < Base
    private

    def build_trigger_id(value)
      "#{NangkaUI::NAMESPACE}-trigger-#{value}"
    end

    def build_content_id(value)
      "#{NangkaUI::NAMESPACE}-content-#{value}"
    end
  end
end
