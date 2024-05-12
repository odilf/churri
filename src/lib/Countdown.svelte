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

<div>
	{time.weeks} semanas
</div>

<div class="flex font-serif text-3xl">
	<RollingNumber start={time.seconds} type="sexagesimal">
		test
	</RollingNumber>
</div>

<div class="flex font-serif text-3xl">
	<RollingNumber start={5.0} type="sexagesimal">
		test2
	</RollingNumber>
</div>
