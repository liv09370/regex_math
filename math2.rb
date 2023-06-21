require 'docx'

# 读取 Word 文档
doc = Docx::Document.open('test2.docx')

# 初始化 previous_paragraph
previous_paragraph = nil

# 遍历每个段落
doc.paragraphs.each do |para|
  # 如果段落包含 "replace:"
  if para.text.start_with?('replace:')
    # 解析替换的值
    replacements = para.text[8..-1].strip.split(',').map do |replacement|
      key, value = replacement.split('=')
      [key.strip, value.strip]
    end.to_h

    # 将公式中的符号替换为适合 LaTeX 的符号
    latex_formula = previous_paragraph.text.gsub('×', '\\times ').gsub('（', '(').gsub('）', ')')

    # 用给定的值替换原始的公式中的变量
    replacements.each do |key, value|
      latex_formula.gsub!(key, value)
    end

    # 用计算的结果替换原始的公式
    previous_paragraph = "$$  \frac{dj=8KF2C}{π[τ]}  $$"
  end

  # 设置 previous_paragraph 为当前段落
  previous_paragraph = para
end

# 保存修改后的文档
doc.save('path_to_your_modified_doc2.docx')
