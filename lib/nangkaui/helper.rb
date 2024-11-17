# frozen_string_literal: true

module NangkaUI
  module Helper
    def build_trigger_id(value, prefix: nil)
      build_element_id("trigger", value, prefix: prefix)
    end

    def build_content_id(value, prefix: nil)
      build_element_id("content", value, prefix: prefix)
    end

    def build_element_id(purpose, value, prefix: nil)
      [NangkaUI::NAMESPACE, prefix, purpose, value].join("-")
    end
  end
end
