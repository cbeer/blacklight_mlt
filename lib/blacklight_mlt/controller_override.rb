# Meant to be applied on top of a controller that implements
# Blacklight::SolrHelper. 
module BlacklightMlt::ControllerOverride
  def self.included(some_class)
    some_class.helper_method :mlt_config
  end

  # Uses Blacklight.config, needs to be modified when
  # that changes to be controller-based. This is the only method
  # in this plugin that accesses Blacklight.config, single point
  # of contact. 
  def mlt_config   
    Blacklight.config[:mlt] || {}
  end
end
