<script lang="ts">
	import type { ComponentProps } from "svelte";
	import RollingDigit from "./RollingDigit.svelte";
	import { digits as getDigits } from "./number";
	import { flip } from "svelte/animate";
	import { fly } from "svelte/transition";

	let {
		value,
		length = "auto",
		digitProps,
	}: {
		value: number;
		length?: "auto" | number;
		digitProps?: (position: number) => Partial<Exclude<ComponentProps<typeof RollingDigit>, "digit">>;
	} = $props();

	let digits = $derived.by(() => {
		const digits = getDigits(value);

		if (length !== "auto") {
			while (digits.length < length) {
				digits.unshift("0");
			}
		}

		return digits;
	});
</script>

<div class="flex w-fit">
	{#each digits as digit, i (digits.length - i)}
		<div class="w-[1ch]" animate:flip transition:fly={{ y: 20 }}>
			<RollingDigit {...digitProps && digitProps(digits.length - i)} {digit} />
		</div>
	{/each}
</div>
