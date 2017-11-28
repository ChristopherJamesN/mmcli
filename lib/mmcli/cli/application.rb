require 'thor'

module Mmcli
 module Cli
   class Application < Thor
     include Thor::Actions

     desc 'mmcli MANIFEST [options] FILE(optional)', 'Add file to, or create, the manifest file MANIFEST and add or delete the file FILE.'
     option :l
     option :d
     option :a
     option :h
     def mmcli(manifest, file = nil)
       if File.exist?(manifest)
         f = File.open(manifest, "r+")
       else
         f = File.new(manifest, "w")
       end
       if options[:d]
         if f.include?(file)
           f.delete(file)
           puts "Successfully deleted #{file} from manifest."
         end
       elsif options[:a]
         if File.exist?(file)
           f.write(file)
           puts "Files successfully added to manifest."
         else
           puts "Error: could not find specified files."
         end
       end
       puts "#{f}" if options[:l]
       puts "-l to list the files in the manifest \n -a to add a file or files to the manifest \n -d to delete a file or files from the manifest \n -h for help" if options[:h]
     end
   end
 end
end
