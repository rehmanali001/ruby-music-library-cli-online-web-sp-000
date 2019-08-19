class MusicLibraryController
  def initialize(path = "./db/mp3s")          #accepts one argument, the path to the MP3 files to be imported
    MusicImporter.new(path).import             #creates a new MusicImporter object, passing in the 'path' value
  end

   def call          #welcomes the user
    input = ""       #init input variable

     while input != "exit"                   #loops and asks for input until they type exit
      puts "Welcome to your music library!"  #welcomes user
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"         #asks for user input

       input = gets.strip

       case input            #CLI Commands
      when "list songs"
        return list_songs   #triggers list_songs
      when "list artists"
        return list_artists #triggers list_artists
      when "list genres"
        return list_genres
      when "list artist"
        return list_songs_by_artist
      when "list genre"
        return list_songs_by_genre
      when "play song"
        return play_song
      end
    end
  end

   def list_songs
   Song.all.sort { |a, b| a.name <=> b.name }.each.with_index(1) do |s, i|       # <=> spaceship useful for sorting an array (to list)
     puts "#{i}. #{s.artist.name} - #{s.name} - #{s.genre.name}"                #string interpolation and mass assignment
   end
 end

   def list_artists
    Artist.all.sort { |a, b| a.name <=> b.name }.each.with_index(1) do |a, i|
      puts "#{i}. #{a.name}"
    end
  end

   def list_genres
    Genre.all.sort { |a, b| a.name <=> b.name }.each.with_index(1) do |g, i|
        puts "#{i}. #{g.name}"
    end
  end

   def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets.strip                          #accepts user input
    #prints all songs by a particular artist in a numbered list (alphabetized by song name)
    if artist = Artist.find_by_name(input)        #does nothing if no matching artist is found
      artist.songs.sort{ |a, b| a.name <=> b.name }.each.with_index(1) do |s, i|
        puts "#{i}. #{s.name} - #{s.genre.name}"
      end
    end
  end

   def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets.strip

     if genre = Genre.find_by_name(input)
      genre.songs.sort{ |a, b| a.name <=> b.name }.each.with_index(1) do |s, i|
        puts "#{i}. #{s.artist.name} - #{s.name}"
      end
    end
  end

   def play_song
    puts "Which song number would you like to play?"
    input = gets.strip.to_i

     if (1..Song.all.length).include?(input)
      song = Song.all.sort{ |a, b| a.name <=> b.name }[input - 1]
    end
    puts "Playing #{song.name} by #{song.artist.name}" if song
  end
end