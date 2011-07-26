module BlacklightMoreLikeThis
  module SolrDocumentExtension
    def self.included some_class
      some_class.after_initialize do
        solr_response.send(:extend, RSolr::Ext::Response::MoreLikeThis) unless solr_response.is_a? RSolr::Ext::Response::MoreLikeThis
      end
    end

    def more_like_this
      return unless solr_response and solr_response.respond_to? :more_like

      solr_response.more_like(self).map { |x| self.class.new(x, solr_response) }
    end
  end
end
