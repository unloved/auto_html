module AutoHtml
  extend self

  def self.add_filter(name, &block)
    AutoHtml::Builder.add_filter(name, &block)
  end

  def auto_html(raw, object=nil, &proc)
    return "" if raw.blank?
    builder = Builder.new(raw, object)
    result = builder.instance_eval(&proc)
    return raw if result.nil?
    result.respond_to?(:html_safe) ?
      result.html_safe :
        result
  end

end
