RSpec.describe Mmcli do

  #Before running tests delete manifest test file if previously created.
  if File.exist?("manifest")
    File.delete("manifest")
  end

  it "has a version number" do
    expect(Mmcli::VERSION).not_to be nil
  end

  describe "Mmcli" do

    it "Can create and/or update the provided manifest file." do
      args = ["mmcli", "manifest", "-a", "b1.txt"]
      Mmcli::Cli::Application.start(args)
      expect(File.exist?("manifest")).to eq(true)
    end

    it "Each path in the manifest file should be on a separate line." do
      args = ["mmcli", "manifest", "-a", "c1.txt"]
      Mmcli::Cli::Application.start(args)
      expect(File.read("manifest")).to eq("b1.txt\nc1.txt\n")
    end

    it "Can list items in the manifest file in a case-insensitive alphabetical order." do
      args =["mmcli", "manifest", "-al", "a2"]
      Mmcli::Cli::Application.start(args)
      expect(File.read("manifest")).to eq("a2/b1.txt\nb1.txt\nc1.txt\n")
    end

    it "Specified path(s) should be added to the manifest file only if all the paths are files that actually exist." do
      args =["mmcli", "manifest", "-a", "d1.txt"]
      Mmcli::Cli::Application.start(args)
      expect(File.read("manifest")).to eq("a2/b1.txt\nb1.txt\nc1.txt\n")
    end

    it "The specified path(s) should be removed from the manifest file or ignored if they are not in the manifest." do
      args =["mmcli", "manifest", "-d", "b1.txt"]
      Mmcli::Cli::Application.start(args)
      expect(File.read("manifest")).to eq("a2/b1.txt\nc1.txt\n")
    end

    it "Does not accept the delete and add option at the same time." do
      args =["mmcli", "manifest", "-ad", "c1.txt"]
      Mmcli::Cli::Application.start(args)
      expect(File.read("manifest")).to eq("a2/b1.txt\nc1.txt\n")
    end

    it "Can accept the list(-l) option with any other option, display after execution of other actions." do
      args =["mmcli", "manifest", "-al", "c1.txt"]
      Mmcli::Cli::Application.start(args)
      expect(File.read("manifest")).to eq("a2/b1.txt\nc1.txt\nc1.txt\n")
    end

    it "Can print a success message if it executed successfully." do
      args =["mmcli", "manifest", "-a", "c1.txt"]
      expect{ Mmcli::Cli::Application.start(args) }.to output("Files successfully added to manifest.\n").to_stdout
    end

    it "Can print a failure message if it failed to execute." do
      args =["mmcli", "manifest", "-a", "d1.txt"]
      expect{ Mmcli::Cli::Application.start(args) }.to output("Error: could not find specified files.\n").to_stdout
    end

  end
end
