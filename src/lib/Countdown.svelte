<script lang="ts">
	import { timeUntil, periods, unitToSpanish, type Unit } from "./time";
	import RollingNumber from "./RollingNumber.svelte";
	import type { ComponentProps } from "svelte";

	let { target }: { target: Date } = $props();

	let [totalMilliseconds, time] = $state(timeUntil(target));

	let paused = $state(false);

	setTimeout(() => {
		paused = true;
	}, totalMilliseconds);

	const unitToRDType: Record<Unit, ComponentProps<RollingNumber>["type"]> = {
		millisecond: "hundreds",
		second: "sexagesimal",
		minute: "sexagesimal",
		hour: "tens",
		day: "tens",
	};
</script>

{#snippet unit(type: Unit)}
	<RollingNumber
		type={unitToRDType[type]}
		start={time[type]}
		period={periods[type]}
		{paused}
		rollAggressive={periods[type] >= periods.hour}
	>
		<!-- TODO: Remove "s" when appropriate. Maybe use Intl API -->
		{unitToSpanish[type]}s
	</RollingNumber>
{/snippet}

<div class="leading-none font-serif text-[min(9vw,12vh)]">
	<div class="text-[3em]">
		{@render unit("day")}
	</div>

	<div class="text-[2em]">
		{@render unit("hour")}
	</div>

	<div class="text-[1em]">
		{@render unit("minute")}
	</div>

	<div class="text-[1em]">
		{@render unit("second")}
	</div>
</div>
