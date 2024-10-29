<script lang="ts">
	import RollingNumber from "$lib/RollingNumber.svelte";
	import { onDestroy } from "svelte";
	import Test from "./Test.svelte";
	import Countdown from "../Countdown.svelte";

	let manualTestValue = $state(0);
	let autoIncreaseTestValue = $state(10);

	const autoIncreaseInterval = setInterval(() => (autoIncreaseTestValue += 1), 500);

	function intoBinaryValue(value: number) {
		const output = [];
		while (value > 0) {
			output.push(value & 1);
			value >>= 1;
		}

		return output.reduceRight((a, b) => a * 10 + b, 0);
	}

	onDestroy(() => {
		clearInterval(autoIncreaseInterval);
	});
</script>

<main class="max-w-xl mx-auto py-8">
	<Test title="manual">
		<div class="flex">
			<button class="flex-1" onclick={() => (manualTestValue -= 1)}> Decrease </button>
			<button class="flex-1" onclick={() => (manualTestValue += 1)}> Increase </button>
			<button class="flex-1" onclick={() => (manualTestValue = Math.floor(Math.random() * 10))}>
				Set to random number
			</button>
		</div>

		<div class="flex justify-center text-4xl">
			<RollingNumber value={manualTestValue} />
		</div>
	</Test>

	<Test title="auto increase">
		<div class="flex gap-2 justify-center text-4xl">
			<RollingNumber
				value={autoIncreaseTestValue}
				digitProps={(i) => ({
					transitionDuration: 300 + 100 * i,
				})}
			/>
		</div>
	</Test>

	<Test title="binary counter">
		<div class="flex justify-center text-4xl">
			<RollingNumber
				value={intoBinaryValue(autoIncreaseTestValue)}
				digitProps={(i) => ({
					transitionDuration: 100 + 100 * i,
				})}
			/>
		</div>
	</Test>

	<Test title="time until">
		<Countdown target={new Date(Date.now() + 1000 * (2 + 60 * 60 * 24))} />
	</Test>

	<Test title="reach 0">
		<Countdown target={new Date(Date.now())} />
	</Test>
</main>
