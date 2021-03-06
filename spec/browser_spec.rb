require File.expand_path('watirspec/spec_helper', File.dirname(__FILE__))

describe Watir::Browser do

  describe ".new" do
    it "passes the args to webdriver" do
      Selenium::WebDriver.should_receive(:for).with(:firefox, :foo).and_return(nil)
      Watir::Browser.new(:firefox, :foo)
    end

    it "takes a Driver instance as argument" do
      mock_driver = mock(Selenium::WebDriver::Driver)
      Selenium::WebDriver::Driver.should_receive(:===).with(mock_driver).and_return(true)

      lambda { Watir::Browser.new(mock_driver) }.should_not raise_error
    end

    it "raises ArgumentError for invalid args" do
      lambda { Watir::Browser.new(Object.new) }.should raise_error(ArgumentError)
    end
  end

  describe "#execute_script" do
    it "returns DOM elements as Watir objects" do
      browser.goto(WatirSpec.files + "/definition_lists.html")
      returned = browser.execute_script("return document.getElementById('experience-list')")
      returned.should be_kind_of(Watir::DList)
    end
  end

  bug "http://github.com/jarib/watirspec/issues/issue/8", [:webdriver, :ie], [:webdriver, :chrome] do
    it "raises an error when trying to interact with a closed browser" do
      b = WatirSpec.new_browser
      b.goto(WatirSpec.files + "/definition_lists.html")
      b.close

      lambda { b.dl(:id => "experience-list").id }.should raise_error(Error, "browser was closed")
    end
  end


end
