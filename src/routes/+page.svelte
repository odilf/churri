<script lang="ts">
	import Countdown from "$lib/Countdown.svelte";
</script>

<main class="h-screen w-screen grid place-content-center font-mono text-md">
	<Countdown target={new Date(2024, 6, 3, 17, 30)}></Countdown>
</main>
