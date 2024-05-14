<script lang="ts">
	import type { Snippet } from "svelte";
	import RollingDigit from "./RollingDigit.svelte";

	let {
		start,
		type = "tens",
		period,
		paused = false,
		children,
	}: {
		start: number;
		type: "units" | "tens" | "hundreds" | "sexagesimal";
		period: number;
		paused?: boolean;
		children?: Snippet;
	} = $props();

	const setup: Record<typeof type, { seximal?: boolean; period: number }[]> = {
		units: [{ period: 1 }],

		tens: [{ period: 10 }, { period: 1 }],

		hundreds: [{ period: 100 }, { period: 10 }, { period: 1 }],

		sexagesimal: [
			{
				seximal: true,
				period: 6,
			},
			{ period: 1 },
		],
	};
</script>

<div class="flex">
	{#each setup[type] as { seximal, period: digitPeriod }, i}
		{@const position = setup[type].length - i - 1}
		{@const startModulus = 10 ** position}

		<RollingDigit start={start / startModulus} period={digitPeriod * period * 10} {seximal} {paused}
		></RollingDigit>
	{/each}

	{#if children}
		<span class="pl-[0.3ch]"> {@render children()} </span>
	{/if}
</div>
