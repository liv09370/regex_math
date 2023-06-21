import net.objecthunter.exp4j.Expression;
import net.objecthunter.exp4j.ExpressionBuilder;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;
import org.apache.poi.xwpf.usermodel.XWPFRun;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

public class WordReplaceExample {
    public static void main(String[] args) {
        try {
            FileInputStream fis = new FileInputStream("path_to_your_doc.docx");
            XWPFDocument document = new XWPFDocument(fis);
            List<XWPFParagraph> paragraphs = document.getParagraphs();

            // 遍历每个段落
            XWPFParagraph previousPara = null;
            for (XWPFParagraph para : paragraphs) {
                String text = para.getParagraphText();

                // 如果段落以 "replace:" 开头
                if (text.startsWith("replace:")) {
                    // 解析替换的值
                    String[] replacements = text.substring(8).split(",");
                    Map<String, Double> values = new HashMap<>();
                    for (String replacement : replacements) {
                        String[] parts = replacement.split("=");
                        String variable = parts[0].trim();
                        Double value = Double.valueOf(parts[1].trim());
                        values.put(variable, value);
                    }

                    // 替换公式中的符号，并将变量替换为 b, t, d, u, z, e
                    String formula = previousPara.getParagraphText();
                    formula = formula.replace("×", "*").replace("（", "(").replace("）", ")").replace("β", "b").replace("μ", "u");

                    // 构建表达式并设置变量值
                    Expression expression = new ExpressionBuilder(formula)
                            .variables(values.keySet())
                            .build()
                            .setVariables(values);

                    // 计算结果
                    double result = expression.evaluate();

                    // 清除原始段落的所有runs
                    int size = previousPara.getRuns().size();
                    for (int i = 0; i < size; i++) {
                        previousPara.removeRun(0);
                    }

                    // 用计算的结果替换原始的公式
                    XWPFRun run = previousPara.createRun();
                    run.setText("F = " + result);
                }

                previousPara = para;
            }

            // 将修改后的文档写入到新的文件
            FileOutputStream out = new FileOutputStream("path_to_your_modified_doc.docx");
            document.write(out);
            out.close();
            document.close();
            fis.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
