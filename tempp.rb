require 'docx_templater'

# 打开第一个文档
doc1 = DocxTemplater::DocxCreator.new({}).generate_docx_bytes("path_to_your_first_document.docx")

# 打开第二个文档
doc2 = DocxTemplater::DocxCreator.new({}).generate_docx_bytes("path_to_your_second_document.docx")

# 在第二个文档的内容后面添加第一个文档的内容
combined_content = doc2 + doc1

# 将组合后的内容保存到一个新的文档中
File.open('path_to_your_combined_document.docx', 'w') { |file| file.write(combined_content) }
