require 'docx'

# 读取 Word 文档
doc = Docx::Document.open('testt.docx')
current_para = nil
# 遍历每个段落
previous_paragraph = nil
current_para = nil
doc.paragraphs.each do |para|
	
  # 如果段落包含 "replace:"
  if para.text.start_with?('replace:')
    # 解析替换的值
    #puts "para: " + para.text
    #puts "previous_paras: " + previous_paragraph.node.inspect
		#puts previous_paragraph.xpath("//m:oMath")
		i = 0
    replacements = para.text[8..-1].strip.split(',').map do |replacement|
      key, value = replacement.split('=')
      [key.strip, value.strip]
      #puts [key.strip, value.strip]
    end.to_h
    puts "replacements: " + replacements.inspect

	
    ts = previous_paragraph.xpath(".//m:t")
		ts.each do |t|
			puts ts.count
			latex_formula = t.children.text.gsub('（', '(').gsub('）', ')')
			#puts latex_formula
			replacements.each do |key, value|
				#puts key
				latex_formula.gsub!(key, value)
			end
			#puts latex_formula
			t.children = latex_formula
			#匹配t里
		end
    # 将公式中的符号替换为适合 LaTeX 的符号

    #latex_formula = previous_paragraph.text.gsub('×', '\\times ').gsub('（', '(').gsub('）', ')')
		#puts latex_formula.inspect
    # 用给定的值替换原始的公式中的变量
    #replacements.each do |key, value|
    #  latex_formula.gsub!(key, value)
    #end

    # 用计算的结果替换原始的公式

		replacements = nil
		latex_formula = nil
		i += 1
    para.remove!
		
  end
  #puts para.text
  previous_paragraph = para
  #puts previous_paragraph.text
end

# 保存修改后的文档
doc.save('path_to_your_modified_doc2.docx')

