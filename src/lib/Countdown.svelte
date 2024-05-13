<script lang="ts">
	import { onDestroy } from "svelte";
	import { timeUntil, periods } from "./time";
	import RollingNumber from "./RollingNumber.svelte";

	let { target }: { target: Date } = $props();

	/**
	 * Time in ms
	 */
	let time = $state(timeUntil(target));

	let updatedTime = $state(timeUntil(target));
	const interval = setInterval(() => {
		updatedTime = timeUntil(target);
	}, 10);

	onDestroy(() => clearInterval(interval));
</script>

<div class="flex font-serif text-9xl">
	{@render weeks()}
</div>

<div class="flex font-serif text-8xl">
	{@render days()}
</div>

<div class="flex font-serif text-8xl">
	{@render hours()}
</div>

<div class="flex font-serif text-4xl">
	{@render minutes()}
</div>

<div class="flex font-serif text-4xl">
	{@render seconds()}
</div>

<style>
	.sideways {
		writing-mode: vertical-rl;
		text-orientation: mixed;
	}
</style>


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
