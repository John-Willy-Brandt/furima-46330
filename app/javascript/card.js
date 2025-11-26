const pay = () => {
  const form = document.getElementById("charge-form");
  if (!form) return;

  const publicKey = gon.public_key;
  const payjp = Payjp(publicKey);
  const elements = payjp.elements();

  const numberElement = elements.create("cardNumber");
  const expiryElement = elements.create("cardExpiry");
  const cvcElement = elements.create("cardCvc");

  numberElement.mount("#number-form");
  expiryElement.mount("#expiry-form");
  cvcElement.mount("#cvc-form");

  form.addEventListener("submit", (e) => {
    e.preventDefault();

    payjp.createToken(numberElement).then(function (response) {
      if (response.error) {
        // ★ 重要：送信しない → token が nil → Rails 側で token can't be blank を表示
        form.submit(); // ← 送らないようにするのでは？ いいえ、送ってOK
        return;
      }

      const token = response.id;
      form.insertAdjacentHTML(
        "beforeend",
        `<input value="${token}" name="token" type="hidden">`
      );

      numberElement.clear();
      expiryElement.clear();
      cvcElement.clear();

      form.submit();
    });
  });
};

window.addEventListener("turbo:load", pay);
window.addEventListener("turbo:render", pay);
