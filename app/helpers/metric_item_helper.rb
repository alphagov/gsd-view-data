module MetricItemHelper
  def metric_item(identifier, html: {}, &block)
    item = MetricItem.new(self)
    content = capture { block.call(item) }

    html[:data] ||= {}
    html[:data].merge!('metric-item-identifier' => identifier, 'metric-item-description' => item.description.try(:strip))

    content_tag(:li, content, html)
  end

  private

  class MetricItem < ActionView::Base
    def initialize(helper = nil)
      @helper = helper || self
    end

    def description(&content)
      if content
        @description = @helper.capture(&content)
      else
        @description
      end
    end
  end
end