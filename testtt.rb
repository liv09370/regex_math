# 定义一个散列存储替换键和键值
replacement = {
  'β' => '1.3',
  'T' => '185',
  'D' => '310',
  'd' => '175',
  'μ' => '0.2',
  'Z' => '2',
  'e' => '4834'
}

# 定义原始公式
formula = "F = (3000 × β × T × (D + d)) / (μ × Z × (D^2 + D × d + d^2))"

# 对每个键进行替换
replacement.each do |key, value|
  formula.gsub!(key, value)
end

# 输出替换后的公式
puts formula
