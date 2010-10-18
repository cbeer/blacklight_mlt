# Meant to be applied on top of Blacklight helpers
module BlacklightMlt::SolrHelperOverride
  def self.included(base)
     base.class_eval do
       alias_method :solr_doc_params_without_mlt, :solr_doc_params
     end
     #base.alias_method_chain :solr_doc_params, :mlt
  end

  def solr_doc_params_with_mlt(id=nil, extra_controller_params={})
    result = solr_doc_params_without_mlt id, extra_controller_params
    ({:mlt => true, 'mlt.fl' => extra_controller_params['mlt.fl'] || mlt_config[:fields], 'mlt.mindf' => extra_controller_params['mlt.mindf'] ||  mlt_config[:mindf] || 1, 'mlt.mintf' => extra_controller_params['mlt.mintf'] || mlt_config[:mintf] || 1 , 'mlt.count' => extra_controller_params['mlt.count'] || mlt_config[:count] || 3 }).deep_merge result
  end

  def get_solr_response_for_doc_id_with_mlt(id=nil, extra_controller_params={})
     solr_response = Blacklight.solr.find solr_doc_params_with_mlt(id, extra_controller_params)
     raise InvalidSolrID.new if solr_response.docs.empty?
     document = SolrDocument.new(solr_response.docs.first)
     [solr_response, document]
  end
end
