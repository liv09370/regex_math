from docx import Document
import re

# 打开docx文件
doc = Document('test2.docx')

# 正则表达式匹配LaTeX表达式
latex_regex = re.compile(r'\$([^$]+)\$')

# 遍历段落
for paragraph in doc.paragraphs:
    # 在段落文本中查找匹配的LaTeX表达式
    matches = latex_regex.findall(paragraph.text)
    for match in matches:
        print(match)
        # 替换LaTeX表达式为指定格式
        replaced_text = f"$$ {match} $$"
        paragraph.text = paragraph.text.replace(f"${match}$", replaced_text)

# 保存修改后的docx文件
doc.save('output.docx')
