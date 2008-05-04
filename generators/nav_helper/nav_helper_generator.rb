class NavHelperGenerator < Rails::Generator::Base
  attr_accessor :helper_name
  def manifest
    record do |m|
      @helper_name = (args[0] || "navigation") + "_helper"
      @helper_name.sub!(/_helper_helper$/, "_helper") # just incase they typed navigation_helper
      m.template "helper.rb", "app/helpers/#{@helper_name}.rb"
    end
  end
  
  protected
  def banner
    puts "Creates a helper for navigation with the method stubs for configuration\n\n"
  end  
  
  def usage_message
    puts "Usage: #{$0} nav_helper helper_name"
  end
  
end