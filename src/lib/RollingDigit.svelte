<script lang="ts" context="module">
	export type RollingDigitProps = {
		start: number;
		period: number;
		easing?: boolean;
		seximal?: boolean;
	};
</script>

<script lang="ts">
	import "./roll.css";

	let {
		period,
		start,
		easing = false,
		seximal = false,
	}: RollingDigitProps = $props();

	let length = $derived(seximal ? 6 : 10);
	let digits = $derived(
		[...Array.from({ length }, (_, i) => i), 0].toReversed(),
	);

	let delay = $derived(period * ((start % length) / length - 1 - 0.01));
</script>

<div class="main">
	{#each digits as digit}
		<div
			style:--period="{period}ms"
			style:--delay="{delay}ms"
			style:--delay-mod-period="{delay % period}ms"
			style:--length={length}
			class="rolling"
			class:easing
		>
			{digit}
		</div>
	{/each}
</div>

<style>
	.main {
		height: 1em;
		overflow: hidden;
	}
</style>
