class User
  attr_accessor :username, :password

  def initialize(username,password)
    @username=username
    @password=password
    array=[@username,@password]    
    CSV.open('db/user.csv','w+') do |csv|
      csv << array
    end
  end

  def self.finduser
    find_gossip=[]
    CSV.read("./db/user.csv").each do |csv_line|
      find_gossip << csv_line[0]
    end
    return find_gossip.join(', ')
  end

  def self.findpassword
    find_gossip=[]
    CSV.read("./db/user.csv").each do |csv_line|
      find_gossip << csv_line[1]
    end
    return find_gossip.join(', ')
  end
end