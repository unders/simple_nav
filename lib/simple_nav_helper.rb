module SimpleNavHelper
  def nav_list
    {}
  end

  def nav_order
    []
  end

  def nav_selection_hash
    {:else => :false}
  end

  def nav_selection_advanced
    nil
  end

  def nav_links
    list = nav_list.merge(:false => {})

    controller = params[:controller].intern
    action = params[:action].intern
    
    selected = (method(:nav_selection_advanced).arity == 2 ? nav_selection_advanced(controller, action) : nav_selection_advanced)
    
    unless selected
      selection_hash = method(:nav_selection_hash).arity == 2 ? nav_selection_hash(controller, action) : nav_selection_hash

      ckey = selection_hash.keys.detect {|cs| cs.is_a?(Array) ? cs.include?(controller) : cs == controller } || :else
      if selection_hash[ckey].is_a?(Hash)
        akey = selection_hash[ckey].keys.detect {|as| as.is_a?(Array) ? as.include?(action) : as == action } || :else
        selected = selection_hash[ckey][akey]
      else
        selected = selection_hash[ckey]
      end
    end
    
    (list[selected || :false][:class] ||= {}) << "selected"

    content_tag :ul do
      nav_order.collect do |key|
        css_class = (list[key][:class] || []).join(" ")
        css_class = nil if css_class.empty?
        content_tag(:li, link_to(list[key][:text], list[key][:href]), :class => css_class)
      end.join("\n")
    end
  end
end