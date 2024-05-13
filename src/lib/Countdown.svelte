<script lang="ts">
	import { timeUntil, periods } from "./time";
	import RollingNumber from "./RollingNumber.svelte";
    import { browser } from "$app/environment";

	let { target }: { target: Date } = $props();

	/**
	 * Time in ms
	 */
	let time = $state(timeUntil(target));

	let viewportWidth: number = $state(browser ? window.innerWidth : 0);
</script>

<svelte:window bind:outerWidth={viewportWidth}></svelte:window>

<div class="leading-none" style:--viewport-width={viewportWidth}>
	<div class="flex font-serif text-[14vw]">
		{@render weeks()}
	</div>

	<div class="flex font-serif text-[10vw]">
		{@render days()}
	</div>

	<div class="flex font-serif text-[8vw]">
		{@render hours()}
	</div>

	<div class="flex font-serif text-[5vw]">
		{@render minutes()}
	</div>

	<div class="flex font-serif text-[5vw]">
		{@render seconds()}
	</div>
</div>

<!-- <style> -->
<!-- 	.main { -->
<!-- 		transform: scale(calc(var(--viewport-width) / 380)); -->
<!-- 	} -->
<!-- </style> -->

{#snippet weeks()}
	<RollingNumber start={time.weeks} period={periods.week} type="hundreds">
		semanas
	</RollingNumber>
{/snippet}

{#snippet days()}
	<!-- TODO: Make type "units" instead of "tens" -->
	<RollingNumber start={time.days} period={periods.day} type="tens">
		días
	</RollingNumber>
{/snippet}

{#snippet hours()}
	<RollingNumber start={time.hours} period={periods.hour} type="tens">
		horas
	</RollingNumber>
{/snippet}

{#snippet minutes()}
	<RollingNumber start={time.minutes} period={periods.minute} type="sexagesimal">
		minutos
	</RollingNumber>
{/snippet}

{#snippet seconds()}
	<RollingNumber start={time.seconds} period={periods.second} type="sexagesimal">
		segundos
	</RollingNumber>
{/snippet}
