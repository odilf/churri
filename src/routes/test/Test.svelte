<script lang="ts">
	import type { Snippet } from "svelte";

	let { title, children }: { title: string; children?: Snippet } = $props();
</script>

<div class="mb-8">
	<h1 class="text-center text-5xl font-bold mb-4">{title}</h1>
	{#if children}
		{@render children()}
	{/if}
</div>
