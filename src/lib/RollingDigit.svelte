<script lang="ts" context="module">
	export type RollingDigitProps = {
		start: number;
		period: number;
		seximal?: boolean;
		paused?: boolean;
	};
</script>

<script lang="ts">
	import "./roll.css";

	let { period, start, seximal = false, paused = false }: RollingDigitProps = $props();

	let length = $derived(seximal ? 6 : 10);
	let digits = $derived([...Array.from({ length }, (_, i) => i), 0].toReversed());

	let delay = $derived(period * ((start % length) / length - 1 ));
</script>

<div class="h-[1em] overflow-hidden">
	{#each digits as digit}
		<div
			style:--period="{period}ms"
			style:--delay="{delay}ms"
			style:--delay-mod-period="{delay % period}ms"
			style:--length={length}
			class="rolling"
			class:paused
		>
			{digit}
		</div>
	{/each}
</div>
