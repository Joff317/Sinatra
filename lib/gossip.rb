require 'bundler'
Bundler.require

class Gossip
   attr_accessor :author, :content 

   def initialize(author, content)
      @author = author
      @content = content
   end

   def save #sauvegarder dans un fichier csv
      CSV.open("./db/gossip.csv", "ab") do |csv|
        csv << [@author, @content]
      end
    end

    def self.all
      all_gossips = []
      CSV.read("./db/gossip.csv").each do |line| #on lit le csv ligne par ligne pour créer un array à afficher
         all_gossips << Gossip.new(line[0], line[1]) #on ajoute, l'autheur et le contenu
      end
      return all_gossips #on affiche l'array
   end

   def self.find(id)
      array_gossips = [] 
      CSV.read("./db/gossip.csv").each_with_index do |line, index|
        if id == index + 1 #regarde si l'index est égal à l'id demandé
            array_gossips << Gossip.new(line[0], line[1])
         break    
         end
      end
      return array_gossips 
   end

   def self.update(id, author, content)
    csv_read = CSV.read("./db/gossip.csv")
    csv_read[id][0] = author
    csv_read[id][1] = content
    CSV.open("./db/gossip.csv", "w+") do |csv|
      csv_read.each do |line|
         csv << line 
      end
    end  
   end
end