<script>
  import { onMount } from "svelte"
  
  let deltaTime = 0
  let duration = 2;
  let elapsedTime = 0
  
  // Update deltaTime
  onMount(() => {
    let currentTime = new Date()
    const interval = setInterval(() => {
      const newTime = new Date()
      deltaTime = (newTime - currentTime) / 1000
      currentTime = newTime
    }, 10);
    return () => clearInterval(interval);
  });
  
  // Track progress
  $: progress = elapsedTime / duration;
  $: done = progress >= 1
  
  // Update elapsedTime
  onMount(() => {
    const interval = setInterval(() => {
      if (!done) {
        elapsedTime += deltaTime
      }
    }, 10);
    return () => clearInterval(interval);
  });
  
  function reset() {
    elapsedTime = 0
  }
</script>

Elapsed time: {elapsedTime.toFixed(1)}<br/>
<progress value={progress} /><br/>
<br/>
Duration: {duration}<br/>
<input type="range" min="1" max="10" bind:value={duration} /><br/>
<br/>
<button on:click={reset}>Reset</button>
