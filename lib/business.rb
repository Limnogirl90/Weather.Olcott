require 'ap'

class Business
  include Capybara::DSL

  BASE_URL = 'http://www.nws.noaa.gov/'
  LOGIN_URI = URI.join(BASE_URL, '/climate/index.php?wfo=buf')

  def initialize
    log_in
  end

private

  def log_in
    visit LOGIN_URI

    s = nil
    reports_form = find(:xpath, '//form[@name="getData"]')
    w = window_opened_by do
      within reports_form do
        go_button = find(:xpath, '//td[@class="a8"][4]/a')
        timeframe = find(:xpath, '//td[@class="a8"][3]')
        within timeframe do
          find(:xpath, 'input[@value="no"]').click
          date_selector = find(:xpath, 'font/select')
          date_selector.select('April 22nd, 2014') #'20140423')
          within date_selector do
            s = all(:xpath, 'option')

            #GAH: won't work
            #my_option = find(:xpath, 'option[@value="20140423"]')
            #select my_option.value
          end
        end
        go_button.click
        #s = find(:xpath, '(//td[@class="a8"]/font/select[@class="a8"])/option').all
      end
    end

    s.each do |opt|
      puts "#{opt.value}: #{opt.text}"
      #puts "#{opt.methods}"
      #break
    end
    
    within_window 'cliPopup' do
      font_node = find(:xpath, '//pre/font')
      #print font_node.text
      str = font_node.text
      arr = str.split("...................................")
      clown = arr[2].clone
      ap clown.scan(/[+\s[:alpha:]()]+[\d\s\.-]+/).map(&:strip)
    end
  end

end
