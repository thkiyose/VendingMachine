class VendingMachine
  # ステップ０　お金の投入と払い戻しの例コード
  # ステップ１　扱えないお金の例コード
  # 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる。
  MONEY = [10, 50, 100, 500, 1000].freeze
  # （自動販売機に投入された金額をインスタンス変数の @slot_money に代入する）
  def initialize
    # 最初の自動販売機に入っている金額は0円
    @slot_money = 0
    # 最初の売上額は0円
    @sales = 0
    # 最初に自動販売機に入っている飲み物
    @drinks = [{ name: "コーラ", price: 120, stock: 5}, {name: "レッドブル", price: 200, stock: 5}, {name: "水", price: 100, stock: 5},]
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
  # 払い戻し操作を行うと、投入金額の総計を釣り銭として出力する。
  def return_money
    # 返すお金の金額を表示する
    puts @slot_money
    # 自動販売機に入っているお金を0円に戻す
    @slot_money = 0
  end
  # 現在の売上を表示する。
  def current_sales
    @sales
  end
  # 現在投入されている金額と飲み物の在庫を確認して、購入出来る飲み物の名前を配列で出力する。
  def show_buyable
    # 買える飲み物の名前を格納する配列を定義
    buyable = []
    # @drinksの各要素の分繰り返す
    @drinks.each do |drink|
      # drinkのpriceが現在の投入金額以上で、drinkのstockが0以上の場合
      if drink[:price] <= @slot_money && drink[:stock] > 0
        # 配列buyableにdrinkのnameを格納
        buyable << drink[:name]
      end
    end
    # 配列buyableを買える飲み物の一覧として返す
    buyable
  end
  # 飲み物の名前を指定して飲み物を購入する
  def buy(drink)
    # 買える飲み物リストに引数drinkが含まれている時
    if show_buyable.include?(drink)
      # 配列@drinksからdrinkに合致するnameを持つ要素を見付け、targetに格納する
      target = @drinks.find { |x| x[:name] == drink }
      # 現在投入している金額からtargetのpriceを引く
      @slot_money -= target[:price]
      # targetのpriceを売上金額@salesに足す
      @sales += target[:price]
      # targetのstockを1減らす
      target[:stock] -= 1
      # 買った飲み物が出てくる表現としてtargetのnameを出力
      puts target[:name]
      # 残金を払い戻す
      return_money
    end
  end
end
