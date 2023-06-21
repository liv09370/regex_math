require 'nokogiri'
require 'zip'

# 解压缩Word文档
def unzip_docx(file, destination)
  Zip::File.open(file) do |zip_file|
    zip_file.each do |f|
      f_path = File.join(destination, f.name)
      FileUtils.mkdir_p(File.dirname(f_path))
      f.extract(f_path)
    end
  end
end

# 压缩Word文档
def zip_docx(source, output_file)
  Zip::File.open(output_file, Zip::File::CREATE) do |zipfile|
    Dir[File.join(source, '**', '**')].each do |file|
      zipfile.add(file.sub(source + '/', ''), file)
    end
  end
end

# 解压缩第一个文档
unzip_docx('test2.docx', 'temp1')

# 解压缩第二个文档
unzip_docx('testt.docx', 'temp2')

# 从第一个文档的XML中读取第一行
doc1 = Nokogiri::XML(File.open('temp1/word/document.xml'))
first_line = doc1.xpath('//w:p').first

# 将第一行添加到第二个文档的XML中
doc2 = Nokogiri::XML(File.open('temp2/word/document.xml'))
doc2.root.add_child(first_line)

# 保存修改后的第二个文档的XML
File.open('temp2/word/document.xml', 'w') { |f| f.write(doc2.to_xml) }

# 重新压缩第二个文档
zip_docx('temp2', 'testtttt.docx')

# 删除临时目录
#FileUtils.rm_rf(['temp1', 'temp2'])
