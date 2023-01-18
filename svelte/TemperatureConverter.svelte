<script>
  let celsius = null;
  let fahrenheit = null;

  function toFahrenheit() {
    fahrenheit = celsius ? celsius * (9 / 5) + 32 : null
  }
  
  function toCelsius() {
    celsius = fahrenheit != null ? (fahrenheit - 32) * (5 / 9) : null
  }
</script>

<input type="number" bind:value={celsius} on:input={toFahrenheit} /> Celsius =
<input type="number" bind:value={fahrenheit} on:input={toCelsius} /> Fahrenheit

<style>
  input {
    width: 100px;
  }
</style>
