<script lang="ts">
	import { RESOURCE } from '@store/server'
	import { SendNUI } from '@utils/SendNUI'

	let { resource, icon, state } = $props();

	async function changeState() {
		event.stopPropagation();
		const data = await SendNUI('setResourceState', { name: resource, state: state });
		RESOURCE.set(data);
	}
</script>

<button
	class="w-[3vh] h-[3vh] rounded-[0.5vh] bg-secondary hover:bg-primary"
	onclick={changeState}
>
	<i class={icon}></i>
</button>
