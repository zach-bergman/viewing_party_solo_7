class Review
  attr_reader :author, :content

  def initialize(review_data)
    @author = review_data[:author]
    @content = review_data[:content]
    @id = review_data[:id]
  end
end