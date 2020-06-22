class VendingMachine
# ステップ０　お金の投入と払い戻しの例コード
# ステップ１　扱えないお金の例コード
# 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる。
MONEY = [10, 50, 100, 500, 1000].freeze
  # （自動販売機に投入された金額をインスタンス変数の @slot_money に代入する）
  def initialize
    # 最初に自販機に入っている飲み物の名前、値段、在庫をハッシュの配列に格納
    @drinks = [{name:"コーラ", price: 120, stock: 5},{name:"レッドブル", price: 200, stock: 5},{name:"水",price:100,stock:5}]
    # 最初に自動販売機に入っている金額は0円
    @slot_money = 0
    # 最初の売上は0円
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
  # 売上の総計を取得できる
  def current_sales
    # 現在の売上を表示する
    @sales
  end
  # 払い戻し操作を行うと、投入金額の総計を釣り銭として出力する。
  def return_money
    # 返すお金の金額を表示する
    puts @slot_money
    # 自動販売機に入っているお金を0円に戻す
    @slot_money = 0
  end
  # 購入可能リストに入っている（買える）飲み物の名前を引数に指定すると、
  # 現在投入している金額から値段分を引き、売上を計上し、飲み物の在庫を1減らし、最後に払い戻しを行う。
  def buy(drink)
    # 引数が購入可能リストに含まれていれば購入処理をし、いなければ何もしない
    if list.include?(drink)
      # 購入する飲み物を名前で検索
      target = @drinks.find { |x| x[:name] == drink }
      # 現在投入している金額から購入する飲み物の値段を引く
      @slot_money -= target[:price]
      # 購入する飲み物の値段を売上に加算する
      @sales += target[:price]
      # 購入する飲み物の在庫を1減らす
      target[:stock] -= 1
      # 払い戻しを行う
      return_money
    end
  end
  # 購入可能な飲み物のリストを出力する
  def list
    # 空のリストを作成
    list = []
    # 飲み物の種類ごとに購入可能か確認する
    @drinks.each do |drink|
      # 飲み物の値段が現在投入している金額以下で、飲み物の在庫がある時
      if drink[:price] <= @slot_money && drink[:stock] > 0
        # 購入可能な飲み物として、リストに飲み物の名前を追加
        list << drink[:name]
      end
    end
    # リストを表示する
    list
  end
end
