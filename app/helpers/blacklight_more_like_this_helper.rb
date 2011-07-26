# Meant to be applied on top of Blacklight helpers
module BlacklightMoreLikeThisHelper
  def render_more_like_this document = @document
    render :partial => 'blacklight_more_like_this/more_like_this', :collection => document.more_like_this
  end
end
