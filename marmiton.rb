class Marmiton
    attr_accessor :recipe_scarped
  def initialize
   @recipe_scarped = []
  end


  def search(keyword)
    html_file = open("http://www.marmiton.org/recettes/recherche.aspx?s=#{keyword}")
    # html_file = open("lib/fraise.html")
    html_doc = Nokogiri::HTML(html_file, nil, "UTF-8")
    # # Scraper les names
    # @recipe_name_scraped = []
    # html_doc.css('div.m_item recette_classique').each do |element|
    #   name =

    #   @recipe_name_scraped << element.text
    # end
    # @recipe_name_scraped.delete_at(0)
    # # Scraper les descriptions
    # @recipe_description_scraped = []
    # html_doc.css('div.m_texte_resultat').each do |element|
    #   @recipe_description_scraped << element.text
    # end
    # @recipe_description_scraped.delete_at(0)
    # # Scraper les temps de cuisson
    # @recipe_cooking_time_scraped = []
    # html_doc.css('div.m_detail_time').each do |element|
    #   @recipe_cooking_time_scraped << element.text
    # end
    # @recipe_description_scraped.delete_at(0)
    # # Scraper difficulté
    # html_doc.css('div.m_detail_recette').each do |element|
    #   recipe_difficult_scraped << element.text
    # end
    # recipe_description_scraped.delete_at(0)
    # recipe_difficult_scraped.each_with_index do |element, index|
    # recipe_difficult_scraped[index] = element.scan(/(\bTrès Facile|\bFacile|\bMoyen|\bDifficile)/).flatten.to_s
    # end
    @recipe_scarped = []
    html_doc.css('.m_contenu_resultat').each do |element|
    name = element.search('.m_titre_resultat a').text
    description = element.search('.m_texte_resultat').text
    cooking_time = element.search('div.m_detail_time').text.scan(/\b\w*.min/).join(" ")
    difficult = element.search('.m_detail_recette').text.scan(/(\bTrès facile|\bFacile|\bMoyen|\bDifficile)/).join("/")
    @recipe_scarped << { name: name, description: description, cooking_time: cooking_time, difficult: difficult }  if name != ""
    end
  end
end
