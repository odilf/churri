<script lang="ts">
    import type { Snippet } from "svelte";
	import RollingDigit from "./RollingDigit.svelte";

	let {
		start,
		type = "tens",
		children,
		easing = true
	}: {
		start: number;
		type: "tens" | "hundreds" | "sexagesimal";
		children: Snippet;
		easing?: boolean;
	}  = $props();
	
	const setup = {
		tens: [
			{
				seximal: false,
				period: 10,
			},
			{
				seximal: false,
				period: 1,
			},
		],

		hundreds: [
			{
				seximal: false,
				period: 10,
			},
			{
				seximal: false,
				period: 1,
			},
		],

		sexagesimal: [
			{
				seximal: true,
				period: 6,
			},
			{
				seximal: false,
				period: 1,
			},
		]
	} satisfies Record<typeof type, unknown>

	const startModuli = [10, 1]
</script>

<!-- {#snippet digit(modulus: number, { seximal }: { seximal: boolean })} -->
<!-- 	<!-- {@const modulus = 10 ** position} --> -->
<!---->
<!-- 	<RollingDigit  -->
<!-- 		start={start / modulus} -->
<!-- 		period={rollingDigitProps.period * modulus * 10} -->
<!-- 		{seximal} -->
<!-- 		{easing} -->
<!-- 	></RollingDigit> -->
<!-- {/snippet} -->

<div class="flex">
	{#each setup[type] as { seximal, period }, i}
		<RollingDigit
			start={start / startModuli[i]}
			period={period * 1000 * 10}
			{seximal}
			{easing}
		></RollingDigit>
	{/each}
	<!-- {#if type === "tens"} -->
	<!-- 	{@render digit(100, { seximal: false })} -->
	<!-- 	{@render digit(10, { seximal: false })} -->
	<!-- {:else if type === "sexagesimal"} -->
	<!-- 	{@render digit(600, { seximal: true })} -->
	<!-- 	{@render digit(10, { seximal: false })} -->
	<!-- {:else if type === "hundreds"} -->
	<!-- 	{@render digit(1000, { seximal: false })} -->
	<!-- 	{@render digit(100, { seximal: false })} -->
	<!-- 	{@render digit(10, { seximal: false })} -->
	<!-- {/if} -->

	<span class="pl-[0.3ch]"> {@render children()} </span>
</div>
