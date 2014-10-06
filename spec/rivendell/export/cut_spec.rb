require 'spec_helper'

describe Rivendell::Export::Cut do

  let(:cart) { double }
  let(:backend_cut) { double cut_name: "010001_002", cart: cart }
  subject { Rivendell::Export::Cut.new backend_cut }

  let(:output_directory) { "tmp/export" }
  after do
    FileUtils.rm_rf output_directory
  end
  
  describe "#export" do

    it "should create a wav file" do
      subject.export target: output_directory, path: "test.wav"
      expect(File.exists?("tmp/export/test.wav")).to be(true)
    end

    it "should create a mp3 file" do
      subject.export target: output_directory, path: "test.mp3"
      expect(File.exists?("tmp/export/test.mp3")).to be(true)
    end
    
  end

  describe "#resolved_path" do

    it "should replace {cut.xyz} by cut attribute" do
      expect(subject.resolved_path("{cut.name}.wav")).to eq("010001_002.wav")
    end

    it "should replace {cart.xyz} by cart attribute" do
      subject.cart.stub title: "dummy"
      expect(subject.resolved_path("{cart.title}.wav")).to eq("dummy.wav")
    end

    it "should replace [object.xyz] by parametrized attribute" do
      subject.cart.stub title: "dummy with space"
      expect(subject.resolved_path("[cart.title].wav")).to eq("dummy-with-space.wav")
    end
    
  end

end
