class VendingMachine
# ステップ０　お金の投入と払い戻しの例コード
# ステップ１　扱えないお金の例コード
# 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる。
MONEY = [10, 50, 100, 500, 1000].freeze
  # （自動販売機に投入された金額をインスタンス変数の @slot_money に代入する）
  def initialize
    # 最初の自動販売機に入っている金額は0円
    @drinks = [{name:"コーラ", price: 120, stock: 5},{name:"レッドブル", price: 200, stock: 5},{name:"水",price:100,stock:5}]
    @slot_money = 0
    @sales = 0
  end
  # 投入金額の総計を取得できる。
  def current_slot_money
    # 自動販売機に入っているお金を表示する
    @slot_money
  end
  # 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる。
  # 投入は複数回できる。
  def slot_money(money)
    # 想定外のもの（１円玉や５円玉。千円札以外のお札、そもそもお金じゃないもの（数字以外のもの）など）
    # が投入された場合は、投入金額に加算せず、それをそのまま釣り銭としてユーザに出力する。
    return false unless MONEY.include?(money)
    # 自動販売機にお金を入れる
    @slot_money += money
  end
  def current_sales
    @sales
  end
  # 払い戻し操作を行うと、投入金額の総計を釣り銭として出力する。
  def return_money
    # 返すお金の金額を表示する
    puts @slot_money
    # 自動販売機に入っているお金を0円に戻す
    @slot_money = 0
  end
  def buy(drink)
    if list.include?(drink)
      target = @drinks.find { |x| x[:name] == drink }
      @slot_money -= target[:price]
      @sales += target[:price]
      return_money
    end
  end
  def list
    lists = []
    @drinks.each do |drink|
      if drink[:price] <= @slot_money && drink[:stock] > 0
        lists << drink[:name]
      end
    end
    lists
  end
end
