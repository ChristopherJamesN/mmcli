require 'thor'

module Mmcli
 module Cli
   class Application < Thor

     @@manifest_list = []

     desc 'mmcli MANIFEST [options] FILE(optional)', 'Add or create the manifest file MANIFEST and add or delete the file FILE.'
     option :l
     option :d
     option :a
     def mmcli(manifest, file = nil)
       if options[:d]
         if @@manifest_list.include?(file)
           @@manifest_list.delete(file)
           puts "Successfully deleted #{file} from manifest."
         end
       elsif options[:a]
         @@manifest_list << file
         puts "Successfully added file to manifest."
       end
       @output = ''
       @@manifest_list.each do |item|
         @output += "#{item} + \n"
       end
       puts "#{@output}" if options[:l]
     end
   end
 end
end
