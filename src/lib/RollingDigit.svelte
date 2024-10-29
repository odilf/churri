<script lang="ts">
	import type { Digit } from "./number";

	let {
		digit,
		transitionDuration = 500,
	}: {
		/**
		 * The digit to display
		 */
		digit: Digit;

		/**
		 * Duration of transition between digits, in milliseconds
		 */
		transitionDuration?: number;
	} = $props();

	// Trigger digit change event
	let oldDigit = $state(digit);
	$effect(() => {
		if (oldDigit === digit) {
			return;
		}

		onDigitChange({ from: oldDigit, to: digit });
		oldDigit = digit;
	});

	type Transition<T = Digit> = {
		from: T;
		to: T;
	};

	let finishTransitionTimeout: number | null = null;
	async function onDigitChange({ from, to }: Transition) {
		transition = { from, to };

		// TODO: What happens when a new transition is received mid-transition
		await new Promise((resolve) => {
			if (finishTransitionTimeout) {
				clearTimeout(finishTransitionTimeout);
			}

			finishTransitionTimeout = setTimeout(resolve, transitionDuration);
		});

		transition = null;
	}

	let transition: Transition | null = $state(null);
</script>

<div class="relative overflow-hidden" style:--transition-duration="{transitionDuration}ms">
	{#if transition === null}
		<div>
			{digit}
		</div>
	{:else}
		<div class="absolute move-up">
			<div class="-translate-y-full">
				{transition.from}
			</div>
		</div>
		<div class="move-up">
			{transition.to}
		</div>
	{/if}
</div>

<style>
	.move-up {
		animation: move-up cubic-bezier(1, 0, 0, 1) var(--transition-duration);
	}

	@keyframes move-up {
		from {
			transform: translateY(100%);
		}

		to {
			transform: translateY(0%);
		}
	}
</style>
