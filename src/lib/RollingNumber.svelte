<script lang="ts">
    import type { Snippet } from "svelte";
	import RollingDigit from "./RollingDigit.svelte";

	let {
		start,
		type = "tens",
		period,
		children,
		easing = true
	}: {
		start: number;
		type: "tens" | "hundreds" | "sexagesimal";
		period: number;
		children?: Snippet;
		easing?: boolean;
	}  = $props();
	
	const setup: Record<typeof type, { seximal?: boolean, period: number }[]> = {
		tens: [
			{
				period: 10,
			},
			{
				period: 1,
			},
		],

		hundreds: [
			{
				period: 100,
			},
			{
				period: 10,
			},
			{
				period: 1,
			},
		],

		sexagesimal: [
			{
				seximal: true,
				period: 6,
			},
			{
				period: 1,
			},
		]
	}
</script>

<div class="flex">
	{#each setup[type] as { seximal, period: digitPeriod }, i}
		{@const position = setup[type].length - i - 1}
		{@const startModulus = 10 ** position}

		<RollingDigit
			start={start / startModulus}
			period={digitPeriod * period * 10}
			{seximal}
			{easing}
		></RollingDigit>
	{/each}
	
	{#if children}
		<span class="pl-[0.3ch]"> {@render children()} </span>
	{/if}
</div>
