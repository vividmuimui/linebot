module Line
  class RequestContent
    attr_reader :user,
      :created_at,
      :text,
      :content_type

    def initialize(content)
      @user = content['from']
      @created_at = content['createdTime']
      @text = content['text']
      @content_type = self.class.content_types[content['contentType']]
    end

    def self.content_types
      {
        1 => :text,
        2 => :image,
        3 => :video,
        4 => :audio,
        7 => :location,
        8 => :sticker,
        10  => :contact
      }.with_indifferent_access
    end
  end
end
