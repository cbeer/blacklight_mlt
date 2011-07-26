module RSolr
  module Ext
    module Response
      module MoreLikeThis
        def more_like document
          mlt = more_like_this[document.id]
          return [] unless mlt and mlt['docs']

          mlt['docs'].map { |x| x.extend RSolr::Ext::Doc }
        end

        def more_like_this
          return {} unless self[:moreLikeThis]
          
          self[:moreLikeThis]
        end
      end
    end
  end
end
