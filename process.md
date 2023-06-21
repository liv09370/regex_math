1. 找到所有replace, 然后他的上一行就是需要替换的公式
2. 把每个公式都新建一个docx文档，复制过去，docx文档按顺序从 1到 n
3. 把docx文档通过pandoc转化为md文件，并按照replace替换
4. 把md再次转化为docx文档
5.1 再次逐行循环文档，找到每个replace上一行的element 替换为 相对应的 小docx文档
5.2 将文档逐行复制到另一个文档，如果包含replace则删除本行及其上一行，然后把对应的小docx 文档添加到文档末尾。
6. 保存新的docx