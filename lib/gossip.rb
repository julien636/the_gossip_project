class Gossip
  attr_reader :author, :content, :comment

  def initialize(author, content, comment)
    @content = content
    @author = author
    @comment=comment
  end

  def save
    array=[self.author,self.content,self.comment]    
    CSV.open('db/gossip.csv','ab') do |csv|
      csv << array
    end
  end

  def self.all
    all_gossips = []
    CSV.read("./db/gossip.csv").each do |csv_line|
      all_gossips << Gossip.new(csv_line[0], csv_line[1],csv_line[2])
    end
    return all_gossips
  end

  def self.find(index)
    find_gossip=[]
    CSV.read("./db/gossip.csv").each do |csv_line|
      find_gossip << Gossip.new(csv_line[0], csv_line[1],csv_line[2])
    end
    return find_gossip[index]
  end

  def self.edit_gossip(index_input,content_input)
    all_gossips= []    
    all_gossips=Gossip.all
    CSV.open('db/gossip.csv','w+')

      all_gossips.each_with_index{|gossip,index|
      if index_input == index
        then
        gossip=Gossip.new(gossip.author,content_input,gossip.comment)
        gossip.save
      else gossip.save
       end
      }
  end

  def self.edit_comment(index_input,comment_input)
    all_gossips= []    
    all_gossips=Gossip.all
    CSV.open('db/gossip.csv','w+')

      all_gossips.each_with_index{|gossip,index|
      if index_input == index
        then
        gossip.comment << ",#{comment_input}"
        gossip.save
      else gossip.save
       end
      }
  end
end


# class Gossip
#   attr_reader :author, :content

#   def initialize(author, content)
#     @content = content
#     @author = author
#   end

#   def save
#     array=[self.author,self.content]    
#     CSV.open('db/gossip.csv','ab') do |csv|
#       csv << array
#     end
#   end

#   def self.all
#     all_gossips = []
#     CSV.read("./db/gossip.csv").each do |csv_line|
#       all_gossips << Gossip.new(csv_line[0], csv_line[1])
#     end
#     return all_gossips
#   end

#   def self.find(index)
#     find_gossip=[]
#     CSV.read("./db/gossip.csv").each do |csv_line|
#       find_gossip << Gossip.new(csv_line[0], csv_line[1])
#     end
#     return find_gossip[index]
#   end

#   def self.edit_gossip(index_input,content_input)
#     all_gossips= []    
#     all_gossips=Gossip.all
#     CSV.open('db/gossip.csv','w+')

#       all_gossips.each_with_index{|gossip,index|
#       if index_input == index
#         then
#         gossip=Gossip.new(gossip.author,content_input)
#         gossip.save
#       else gossip.save
#        end
#       }
#   end
# end
