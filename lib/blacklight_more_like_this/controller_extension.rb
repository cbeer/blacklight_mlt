# Meant to be applied on top of a controller that implements
# Blacklight::SolrHelper. 
module BlacklightMoreLikeThis::ControllerExtension
  def self.included(some_class)
    some_class.helper_method :more_like_this_config
    some_class.helper BlacklightMoreLikeThisHelper
    some_class.send(:include, BlacklightMoreLikeThis::SolrHelperExtension)
  end

  # Uses Blacklight.config, needs to be modified when
  # that changes to be controller-based. This is the only method
  # in this plugin that accesses Blacklight.config, single point
  # of contact. 
  def more_like_this_config   
    blacklight_config.more_like_this || {}
  end
end
