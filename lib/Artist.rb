class Artist 

    extend Concerns::Findable
    attr_accessor :name, :songs
  
    @@all = []
    
  def initialize(name)
    @name = name 
    @songs = []
  end 
  
  def save 
    @@all << self 
  end
  
  def self.all
    @@all 
  end
  
  def self.destroy_all
    @@all.clear
  end 
  
  def self.create(name)
    new_artist = Artist.new(name)
    new_artist.save
    new_artist
  end
  
  def add_song(song)
    song.artist = self if song.artist == NIL
    @songs << song if songs.none? {|song_1| song_1 == song}
  end 
  
  def genres
    genres = []
    @songs.each {|song| genres << song.genre}
    genres.uniq
  end 
end 