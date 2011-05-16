# Meant to be applied on top of Blacklight helpers
module BlacklightMlt::SolrHelperOverride

  def get_solr_response_for_doc_id(id=nil, extra_controller_params={})

    extra_controller_params = ({:mlt => true, 'mlt.fl' => extra_controller_params['mlt.fl'] || mlt_config[:fields], 'mlt.mindf' => extra_controller_params['mlt.mindf'] ||  mlt_config[:mindf] || 1, 'mlt.mintf' => extra_controller_params['mlt.mintf'] || mlt_config[:mintf] || 1 , 'mlt.count' => extra_controller_params['mlt.count'] || mlt_config[:count] || 3, 'mlt.qf' => extra_controller_params['mlt.qf'] || mlt_config[:qf] }).merge(extra_controller_params)

    result = super(id, extra_controller_params)
  end

  def get_more_like_this_for_doc_id(id=nil, extra_controller_params={})
     doc = nil
     
     response = @response if @response['moreLikeThis']
     response, document =  get_solr_response_for_doc_id id, extra_controller_params unless @response['moreLikeThis']
     doc ||= response['moreLikeThis'].first.last if id.nil?
     doc ||= response['moreLikeThis'][id] unless response['moreLikeThis'][id].nil?

     doc['docs'].map { |d| SolrDocument.new(d) } 
  end
end
