require 'docx'
require 'nokogiri'

def extract_latex_from_docx(file_path)
  doc = Docx::Document.open(file_path)
  latex_expressions = []

  doc.paragraphs.each do |paragraph|
    latex_expressions += paragraph.text.scan(/\$\$(.*?)\$\$/)
  end
  puts latex_expressions
  latex_expressions.flatten
end

def convert_latex_to_string(latex)
  html = "<html><body><div id='math'>#{latex}</div></body></html>"
  mathjax_script = '<script src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.2/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>'

  full_html = html + mathjax_script

  doc = Nokogiri::HTML(full_html)
  doc.xpath('//script').remove # 移除脚本标签
  doc.xpath('//text()').to_a.join(' ').strip
end

def latex_to_string(file_path)
  latex_expressions = extract_latex_from_docx(file_path)
  puts latex_expressions
  converted_strings = []

  latex_expressions.each do |latex|
    converted_strings << convert_latex_to_string(latex)
  end

  converted_strings.join("\n")
end

# 使用示例
docx_file_path = 'testt.docx'
converted_string = latex_to_string(docx_file_path)
puts converted_string
