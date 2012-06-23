require 'spec_helper'

describe Maybelline::Maybe do
  let(:object) do
    mock(:object,
      :i_wanna_nil => nil
    )
  end
  subject{Maybelline::Maybe.new(object)}

  it "should delegate methods to the inner object" do
    object.should_receive(:a_method).and_return(1)

    subject.a_method
  end

  it "should throw :nothing if the method called on it returns nil" do
    expect{subject.i_wanna_nil}.to throw_symbol
  end

  it "should thow :nothing if initialized with nil" do
    expect{Maybelline::Maybe.new(nil)}.to throw_symbol
  end

  it "should expose the internal object with __object__" do
    subject.__object__.should == object
  end
end

describe "#Maybe" do
  let(:object) do
    mock(:object).tap do |object|
      object.stub_chain(:bob, :rob, :jack).and_return(nil)
      object.stub_chain(:rob, :bob, :jack).and_return(1)
    end
  end

  it "should return nil if any method in the chain returns nil and not execute the subsequent methods" do
    result = Maybe(object){|o| o.bob.rob.jack.not_called}
    result.should be_nil
  end

  it "should return the value if the chain of methods is successful" do
    result = Maybe(object){|o| o.rob.bob.jack}
    result.should == 1
  end

  it "should not call the block when called when nil is passed" do
    executed = false
    Maybe(nil){executed = true}
    executed.should be_false
  end
end

describe "#maybe" do
  let(:proc){:to_s.to_proc}

  it "should call Maybe with the object maybe is called on" do
    Maybelline::Maybe.should_receive(:new).with(1, &proc)

    1.maybe(&proc)
  end
end