require 'mechanize'

class USBank

  attr_accessor :username, :password, :challenges

  attr_reader :agent, :dashboard_url

  def initialize(attributes={})
    attributes.each { |k,v| send("#{k}=", v) }
    self.challenges ||= {}
  end

  def login
    @agent = Mechanize.new

    page = @agent.get 'https://www4.usbank.com/internetBanking/RequestRouter?requestCmdId=DisplayLoginPage'
    form = page.form_with :name => 'logon'
    form['USERID'] = username
    page = form.submit 

    form = page.forms.first
    question = (challenges).keys.find { |question| page.body.include? question }
    raise 'Challenge question not found' unless question
    form["CHALLENGEANSWER"] = challenges[question]
    page = form.submit
    
    form = page.forms.first
    form["PSWD"] = password
    page = form.submit

    raise "SSO redirect not found after password submission." unless page.body =~ /MM SSO/i && page.forms.any?
    page = page.forms.first.submit

    raise "Dashboard not found after SSO redirect." unless page.body =~ /U.S. Bank - Customer Dashboard/i
    @dashboard_url = page.uri
  end

  def fetch account_index=2, options = {}
    login unless dashboard_url
    from = options.delete(:from) || Date.today - 90
    to   = options.delete(:to)   || Date.today
    download_path = "AccountDashboard/DownloadTrans.ashx?index=#{account_index}&from=#{from.to_s}&to=#{to.to_s}&type=qfx"
    download_url = dashboard_url.to_s.gsub('CustomerDashboard/Index', download_path)
    agent.get(download_url).body
  end

end
