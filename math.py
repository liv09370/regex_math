from docx  import Document

# 读取 Word 文档
doc = Document('test.docx')
#doc = Document2('test.docx')
# 初始化 previous_paragraph
previous_paragraph = None
#text = doc.get_text()
#print(text)
# 遍历每个段落
for para in doc.paragraphs:
  # 如果段落包含 "replace:"
  if para.text.startswith('replace:'):
    # 解析替换的值
    replacements = {key.strip(): value.strip() for key, value in 
                   (item.split('=') for item in para.text[8:].split(','))}

    # 将公式中的符号替换为适合 LaTeX 的符号
    print(previous_paragraph.text)
    latex_formula = previous_paragraph.text.replace('×', '\\times ').replace('（', '(').replace('）', ')')

    # 用给定的值替换原始的公式中的变量
    for key, value in replacements.items():
      latex_formula = latex_formula.replace(key, value)

    # 用计算的结果替换原始的公式
    previous_paragraph.text = "$$  \frac{dj=8KF2C}{π[τ]}  $$"

  # 设置 previous_paragraph 为当前段落
  previous_paragraph = para

# 保存修改后的文档
doc.save('path_to_your_modified_doc.docx')
