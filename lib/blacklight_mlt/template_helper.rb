# Meant to be applied on top of Blacklight helpers
module BlacklightMlt::TemplateHelper
  def render_more_like_this
    render :partial => 'blacklight_mlt/mlt', :collection => get_more_like_this
  end
  def get_more_like_this id=nil
    return [] unless @response['moreLikeThis']
    doc = nil

    doc ||= @response['moreLikeThis'].first.last if id.nil?
    doc ||= @response['moreLikeThis'][id] unless @response['moreLikeThis'][id].nil?

    return [] unless doc['docs']

    doc['docs'].map { |d| SolrDocument.new(d) }
  end
end
