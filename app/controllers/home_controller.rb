require 'AlchemyAPI'
class HomeController < ApplicationController

  def generate
    alchemy = AlchemyAPI.new("2094dd01fd7cbceb7e1bb916840e40e81f25d16f")
    results = alchemy.textGetRankedKeywords(params[:q])
    marketing = ['marketing', 'web page', 'webpage', 'info', 'information', 'informative', 'business', 'advertis']
    blog = ['blog', 'post', 'blog post', 'journal', 'timeline']
    contact = ['contact', 'message', 'about', 'email']

    if (checkForType results, marketing)
      type = Type.find_by_name('marketing')
    elsif (checkForType results, blog)
      type = Type.find_by_name('blog-post')
    elsif (checkForType results, contact)
      type = Type.find_by_name('contact')
    end
    redirect_to show_page_path(type.id)
  end

  def checkForType keywords, array
    array.each do |elem|
      return true if keywords.include? elem
    end
    return false
  end
end