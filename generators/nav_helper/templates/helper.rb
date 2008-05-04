module <%= helper_name.camelcase %>
  include SimpleNavHelper
  
  # the nav_list method defines the navigation links as a hash with its options
  # order does not matter, and note that they will only appear once listed
  # in the nav_order method
  # EXAMPLE:
  # {
  #   :home => {:text => "Home", :href => home_path},
  #   :login => {:text => "Login", :href => login_path, :class => ["right"]},
  #   :logout => {:text => "Logout", :href => logout_path, :class => ["right"]},
  #   :signup => {:text => "Sign Up", :href => signup_path},
  #   :settings => {:text => "Settings", :href => settings_path}
  # }
  def nav_list
    {}
  end


  # the nav_order method simply returns of an array containing the order
  # to display them for this request
  # note that the values are the keys of the hashes from the nav_list method
  # EXAMPLE:
  # if logged_in?
  #   [:home, :settings, :logout]
  # else
  #   [:home, :signup, :login]
  # end
  def nav_order
    []
  end


  # the nav_selection_hash method is used to determine which tab is currently
  # set as selected. the selected tab's li element has the additional class of "selected"
  # the first set of keys are the controllers (either in as an array or individually)
  # the value can be either a symbol (corresponding to the key of the tab to select)
  #     or another hash to further narrow down using the action
  # EXAMPLE:
  # {
  #   # so this means that if the controller is the users controller, the :settings tab is selectted
  #   :users => :settings,
  #
  #   # this one means that new and create actions from the sessions controller
  #   # make the login tab selected, logout makes logout selected, otherwise (else) no tab is selected (:false)
  #   :sessions => {[:new, :create] => :login, :logout => :logout, :else => :false},
  #
  #   # this leverages the fact that the controller key can be an array as well
  #   # so any action in the pages or info controllers select the home tab
  #   [:pages, :info] => :home,
  #
  #   # otherwise, no tab is selected
  #   :else => :false
  # }
  # this method can optionally be sent 2 arguemnts (controller and action)
  # so you can change it to "def nav_selection_hash(controller, action)" and
  # use those two variables in this method
  # Note: Use the nav_selection_advanced method below for advanced logic that can't
  #       be boiled down to the simple logic here
  def nav_selection_hash
    {:else => :false}
  end


  # the nav_selection_advanced method is for advacned logic for determing which
  # tab to select, it can optionally be passed with two arguments: controller & action
  # it can do anything you want, if it returns a value, it should be the key
  # of the nav link you want selected. if it returns nil or false, it will try
  # to determine the selected tab from the nav_selection_hash above
  def nav_selection_advanced
    nil
  end
end