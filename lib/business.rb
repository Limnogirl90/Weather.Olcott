require 'ap'

class Business
  include Capybara::DSL

  BASE_URL = 'http://www.nws.noaa.gov/'
  LOGIN_URI = URI.join(BASE_URL, '/climate/index.php?wfo=buf')

  def initialize
    log_in
  end

private

  attr_accessor :go_button, :timeframe, :date_selector, :font_node, :str, :arr, :clown, :s

  def do_setup

    visit LOGIN_URI
    reports_form = find(:xpath, '//form[@name="getData"]')

    # w was not useful, had to call cliPopup by name to within_window
    #w = window_opened_by do
    #end
    within reports_form do
      go_button = find(:xpath, '//td[@class="a8"][4]/a')
      timeframe = find(:xpath, '//td[@class="a8"][3]')
      #s = find(:xpath, '(//td[@class="a8"]/font/select[@class="a8"])/option').all
    end
    within timeframe do
      find(:xpath, 'input[@value="no"]').click
      date_selector = find(:xpath, 'font/select')
    end
  end

  def log_in
    do_setup
    within date_selector do
      s = all(:xpath, 'option')
    end

    s.each do |opt|
      #puts "#{opt.methods}"
      #break
      puts "#{opt.value}: #{opt.text}"
      date_selector.select(opt.text) #'April 22nd, 2014') #'20140423')
      go_button.click

      within_window 'cliPopup' do
        font_node = find(:xpath, '//pre/font')
        #print font_node.text
        str = font_node.text
        arr = str.split("...................................")
        clown = arr[2].clone
        p clown.scan(/[+\s[:alpha:]()]+[\d\s\.-]+/).map(&:strip)
        do_setup
      end
    end
  end
end
