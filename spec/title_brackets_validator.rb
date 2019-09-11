class TitleBracketsValidator < ActiveModel::Validator
  def validate(arg)
    arg.errors.add(:title, 'Invalid title') unless brackets_valid?(arg.title)
  end

  def brackets_valid?(title)
    charopeners_to_charclosers = {
      '(' => ')',
      '{' => '}',
      '[' => ']'
    }

    charopeners_stack = []

    title.each_char.with_index do |c, i|
      charopeners_stack << c if charopeners_to_charclosers.key?(c)
      return false if charopeners_to_charclosers.key(title[i + 1]) == c
      return false if charopeners_to_charclosers.key(c) && charopeners_to_charclosers.key(c) != charopeners_stack.pop
    end
    charopeners_stack.empty?
  end
end
  