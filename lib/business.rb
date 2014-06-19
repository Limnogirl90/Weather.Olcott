require 'ap'

class Business
  include Capybara::DSL

  BASE_URL = 'http://www.nws.noaa.gov/'
  LOGIN_URI = URI.join(BASE_URL, '/climate/index.php?wfo=buf')

  def initialize(i)
    log_in(i)
  end

private

  def log_in(i)
    visit LOGIN_URI

    s = nil
    reports_form = find(:xpath, '//form[@name="getData"]')
    go_button = nil
    date_selector = nil
    within reports_form do
      go_button = find(:xpath, '//td[@class="a8"][4]/a')
      timeframe = find(:xpath, '//td[@class="a8"][3]')
      within timeframe do
        find(:xpath, 'input[@value="no"]').click
        date_selector = find(:xpath, 'font/select')
        within date_selector do
          s = all(:xpath, 'option')
        end
      end
    end

    h = {}
    s.each do |opt|
      h[opt.value]=opt.text
    end
    #ap h

    text = h[i]
    puts text
    date_selector.select(text)
    go_button.click
    within_window 'cliPopup' do
      font_node = find(:xpath, '//pre/font')
      str = font_node.text
      arr = str.split("...................................")
      clown = arr[2].clone
      p str
      ap clown.scan(/[+\s[:alpha:]()]+[\d\s\.-]+/).map(&:strip)
    end
  end

end
