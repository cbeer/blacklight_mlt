# Meant to be applied on top of Blacklight helpers
module BlacklightMoreLikeThis::SolrHelperExtension

  def self.included some_class
    some_class.solr_search_params_logic += [:add_solr_mlt_parameters]
  end

  def add_solr_mlt_parameters solr_parameters, user_parameters
    config = more_like_this_config
    config ||= {}

    return unless config['enable_mlt_in_search_results'] or solr_parameters[:id]

    solr_parameters[:mlt] = true
    solr_parameters['mlt.count'] = 3
    solr_parameters['mlt.mintf'] = 1

    config.keys.select { |x| x.to_s =~ /mlt/ }.each do |k|
      solr_parameters[k] = config[k]
    end
  end

  def solr_doc_params(*args)
    config = more_like_this_config
    config ||= {}

    solr_parameters = super(*args)

    add_solr_mlt_parameters(solr_parameters, {})

    solr_parameters
  end  

end
