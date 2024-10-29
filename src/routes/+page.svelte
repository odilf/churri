<script lang="ts">
	import Countdown from "./Countdown.svelte";
	import { env } from '$env/dynamic/public';
	import { error } from "@sveltejs/kit";


	const getDate = (input: string | undefined) => {
		if (input === undefined) {
			throw error(500, "Target date is not set");
		}
		
		const date = new Date(input);
		if (Number.isNaN(date.valueOf())) {
			throw error(500, `Target date cannot be parsed (was "${input}")`);
		}

		return date;
	}

	const target = getDate(env.TARGET_DATE);
</script>

<main class="h-screen w-screen grid place-content-center font-mono text-md">
	<Countdown {target} />
</main>
