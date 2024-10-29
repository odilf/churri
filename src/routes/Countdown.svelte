<script lang="ts">
	import { periods, timeUntil, unitToSpanish, type Unit } from "$lib/time";
	import RollingNumber from "$lib/RollingNumber.svelte";
	import { fly } from "svelte/transition";

	let {
		target,
		refreshRate = 100,
	}: {
		target: Date;
		refreshRate?: number;
	} = $props();

	let [totalMilliseconds, time] = $state(timeUntil(target));

	setInterval(() => {
		[totalMilliseconds, time] = timeUntil(target);
	}, refreshRate);
</script>

{#snippet unit(type: Unit, textSize: string)}
	{@const value = Math.floor(time[type])}

	<div class="flex gap-4 {textSize}">
		<RollingNumber
			{value}
			length={2}
			digitProps={(i) => ({
				transitionDuration: Math.log2(periods[type]) * 50 + 100 * i,
			})}
		/>
		<span class="ml-4">
			{unitToSpanish[type](value)}
		</span>
	</div>
{/snippet}

<div class="leading-none mx-auto font-serif text-[min(9vw,12vh)]" in:fly|global={{ y: 200 }}>
	{@render unit("day", "text-[3em]")}
	{@render unit("hour", "text-[2em]")}
	{@render unit("minute", "text-[1em]")}
	{@render unit("second", "text-[0.8em]")}
</div>
