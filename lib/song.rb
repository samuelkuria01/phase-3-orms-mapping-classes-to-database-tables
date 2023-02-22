class Song

  attr_accessor :name, :album

  def initialize(name:, album:)
    @name = name
    @album = album
  end

  def self.create_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS song (
      id INTEGER PRIMARY KEY,
      name TEXT,
      album TEXT
    )
    SQL

    DB[:conn].execute(sql)

  end

  def save 
    sql = <<-SQL
    INSERT INTO songs (name, album)
    VALUES(?, ?)
    SQL

    #insert the song, ..a new row into the database
    DB[:conn].execute(sql, self.name, self.album)

    #get song id from the database and save it to the ruby instance
    self.id = DB[:conn].execute("SELECT last_insert_rowid() FROM songs")[0][0]

    #return the ruby instance
    self
  end

  def self.create(name:, album:)
  song = Song.new(name: name, album: album)
  song.save
  end
end
