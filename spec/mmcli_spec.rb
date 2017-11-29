RSpec.describe Mmcli do

  it "has a version number" do
    expect(Mmcli::VERSION).not_to be nil
  end

  describe ".mmcli" do

    it "Can create and/or update the provided manifest file." do
      args = ["mmcli", "-a", "b1.txt"]
      options = Mmcli::Cli::Application.start(args)
      expect(options).to eq({ "a" => true })
    end

    it "Each path in the manifest file should be on a separate line." do
      args = ["mmcli", "-a", "c1.txt"]
      options = Mmcli::Cli::Application.start(args)
      expect(options).to eq({ "a" => true })
    end

    it "Can list items in the manifest file in a case-insensitive alphabetical order." do
      args =["mmcli", "-l"]
      list = Mmcli::Cli::Application.start(args)
      expect(list).to eq("b1.txt\nc1.txt")
    end

    it "Specified path(s) should be added to the manifest file only if all the paths are files that actually exist." do
      args =["mmcli", "-a", "d1.txt"]
      list = Mmcli::Cli::Application.start(args)
      expect(list).to eq("Error: could not find specified files.")
    end

    it "The specified path(s) should be removed from the manifest file or ignored if they are not in the manifest." do
      args =["mmcli", "-d", "b1.txt"]
      list = Mmcli::Cli::Application.start(args)
      expect(list).to eq("a1.txt")
    end

    it "Does not accept the delete and add option at the same time." do
      args =["mmcli", "-ad", "b1.txt"]
      list = Mmcli::Cli::Application.start(args)
      expect(list).to eq("You cannot specify both options add and delete simultaneously.")
    end

    it "Can accept the list(-l) option with any other option, display after execution of other actions." do
      args =["mmcli", "-al", "c1.txt"]
      list = Mmcli::Cli::Application.start(args)
      expect(list).to eq("b1.txt\nc1.txt")
    end

    it "Can print a success message if it executed successfully." do
      args =["mmcli", "-al", "c1.txt"]
      list = Mmcli::Cli::Application.start(args)
      expect(list).to eq("Files successfully added to manifest.")
    end

    it "Can print a failure message if it failed to execute." do
      args =["mmcli", "-al", "d1.txt"]
      list = Mmcli::Cli::Application.start(args)
      expect(list).to eq("Error: could not find specified files.")
    end

  end
end
