module SimpleNavHelper
  def nav_list(namespace)
    {}
  end

  def nav_order(namespace)
    []
  end

  def nav_selection_hash(namespace)
    {:else => :false}
  end

  def nav_selection_advanced(namespace)
    nil
  end

  def nav_links(namespace = nil)
    controller = params[:controller].intern
    action = params[:action].intern    
    
    list = nav_list(namespace).merge(:false => {})

    selected = method(:nav_selection_advanced).arity == 3 ? nav_selection_advanced(controller, action, namespace) : nav_selection_advanced(namespace)    
    
    unless selected
      selection_hash = method(:nav_selection_hash).arity == 3 ? nav_selection_hash(controller, action, namespace) : nav_selection_hash(namespace)

      ckey = selection_hash.keys.detect {|cs| cs.is_a?(Array) ? cs.include?(controller) : cs == controller } || :else
      if selection_hash[ckey].is_a?(Hash)
        akey = selection_hash[ckey].keys.detect {|as| as.is_a?(Array) ? as.include?(action) : as == action } || :else
        selected = selection_hash[ckey][akey] || selection_hash[:else]
      else
        selected = selection_hash[ckey]
      end
    end
    
    (list[selected || :false][:class] ||= []  ) << "selected"
    
    content_tag :ul, :id => namespace, :class => "simple_nav" do
      nav_order(namespace).collect do |key|
        css_class = (list[key][:class] || []).join(" ")
        css_class = nil if css_class.empty?
        content_tag(:li, link_to(list[key][:text], list[key][:href]), :class => css_class)
      end.join("\n")
    end
  end
end
