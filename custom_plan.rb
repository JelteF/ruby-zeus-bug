require "zeus/rails"

class CustomPlan < Zeus::Rails
  # boot is a required step, but we simply keep it empty
  def boot
  end

  # default_bundle loads our regular dependencies
  def default_bundle
    require "rubocop"
  end

  def final_goal
  end
end

Zeus.plan = CustomPlan.new
