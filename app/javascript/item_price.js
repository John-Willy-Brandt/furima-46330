// 価格入力に応じて手数料と利益を計算して表示する

const setupPriceCalculation = () => {
  const priceInput = document.getElementById("item-price");
  const taxOutput = document.getElementById("add-tax-price");
  const profitOutput = document.getElementById("profit");

  // new.html.erb 以外のページでは何もしない
  if (!priceInput || !taxOutput || !profitOutput) return;

  priceInput.addEventListener("input", () => {
    const price = parseInt(priceInput.value, 10);

    // 数字が入っていないときは表示をクリア
    if (isNaN(price)) {
      taxOutput.textContent = "";
      profitOutput.textContent = "";
      return;
    }

    const tax = Math.floor(price * 0.1); // 10% を小数切り捨て
    const profit = price - tax;

    taxOutput.textContent = tax;
    profitOutput.textContent = profit;
  });
};

// Rails 7 + Turbo 用：ページ読み込みのたびにセットアップ
window.addEventListener("turbo:load", setupPriceCalculation);
// Turbo を使っていない場合用の保険（あっても害はない）
window.addEventListener("DOMContentLoaded", setupPriceCalculation);
