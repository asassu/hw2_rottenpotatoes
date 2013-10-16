module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end

  def self.ratings
    self.select("DISTINCT(rating)").map(&:rating)
  end
end
