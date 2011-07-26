# BlacklightMoreLikeThis

require 'rsolr-ext/response/more_like_this'

module BlacklightMoreLikeThis
  require 'blacklight_more_like_this/version'
  require 'blacklight_more_like_this/engine'
  autoload :ControllerExtension, 'blacklight_more_like_this/controller_extension'
  autoload :SolrHelperExtension, 'blacklight_more_like_this/solr_helper_extension'
  autoload :SolrDocumentExtension, 'blacklight_more_like_this/solr_document_extension'
end
