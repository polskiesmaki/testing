fetch("./func_test.wasm")
  .then(response => response.arrayBuffer())
  .then(bytes => WebAssembly.instantiate(bytes))
  .then(results => {
    console.log("Loaded wasm module");

    const instance = results.instance;
    console.log("Instance:", instance);

    // Definierte Werte für Spielsteine
    const white = 2;
    const black = 1;
    const crowned_white = 6;
    const crowned_black = 5;

    // Offset für Position (3,4)
    console.log("Calling offset...");
    const offset = instance.exports.offsetForPosition(3, 4);
    console.log("Offset for (3,4) is", offset);

    // Überprüfungen der Farben und Kronen
    console.log("White is white?", instance.exports.isWhite(white));
    console.log("Black is black?", instance.exports.isBlack(black));
    console.log("Black is white?", instance.exports.isWhite(black));

    console.log(
      "Uncrowned white:",
      instance.exports.isWhite(instance.exports.withoutCrown(crowned_white))
    );

    console.log(
      "Uncrowned black:",
      instance.exports.isBlack(instance.exports.withoutCrown(crowned_black))
    );

    console.log("Crowned is crowned:", instance.exports.isCrowned(crowned_black));
    console.log("Crowned is crowned (b):", instance.exports.isCrowned(0));
  })
  .catch(error => console.error("Error loading WASM module:", error));
