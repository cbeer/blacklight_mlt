# Meant to be applied on top of Blacklight helpers
module BlacklightMlt::ViewHelperOverride
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
  
  def get_more_like_this_for_doc_id(id=nil, extra_controller_params={})
     doc = nil
     
     response = @response if @response['moreLikeThis']
     response, document =  get_solr_response_for_doc_id_with_mlt id, extra_controller_params unless @response['moreLikeThis']
     doc ||= response['moreLikeThis'].first.last if id.nil?
     doc ||= response['moreLikeThis'][id] unless response['moreLikeThis'][id].nil?

     doc['docs'].map { |d| SolrDocument.new(d) } 
  end

  def render_more_like_this(id=nil, extra_controller_params={})
    render :partial => 'blacklight_mlt/mlt', :collection => get_more_like_this_for_doc_id(id,extra_controller_params)
  end
end
