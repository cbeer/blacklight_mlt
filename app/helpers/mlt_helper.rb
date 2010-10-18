module MltHelper
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
