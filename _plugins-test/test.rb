require 'time'
require 'open-uri'
require 'nokogiri'

def generate
  auction_id = "galleriaricho"
  html = open("https://auctions.yahoo.co.jp/seller/galleriaricho?n=100&sid="+auction_id+"&b=1&s1=end&o1=a&mode=1&anchor=1").read

  doc = Nokogiri::HTML.parse(html, nil, nil)
  doc.css('#list01 > div.inner.cf > div.bd.cf').each do |entry_elem|
    #etm = Time.at((entry_elem.css('div.a.cf > h3 > a').attributes['data-ylk'].match('etm=([0-9]+),')[0]).to_i)
    etm = Time.at((entry_elem.at_css('div.a.cf > h3 > a').attributes['data-ylk'].value).match('etm=([0-9]+),')[1].to_i, in: "+09:00")
    p(etm)
    # Date.today
  end

  # レイアウト側で使えるようにsite.dataに値を入れておく
  # site.data.merge!({ "items" => result['contents'] })
end

generate