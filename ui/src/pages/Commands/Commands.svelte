<script>
	import { MENU_WIDE } from '@store/stores'
	import { COMMANDS } from '@store/server'

	import Header from '@components/Header.svelte'
	import CommandsCard from './components/CommandsCard.svelte'

	let search = $state('')
	let visibleCount = $state(50)
	const pageSize = 50

	let sortedCommands = $derived($COMMANDS
		? $COMMANDS.slice().sort((a, b) => a.name.localeCompare(b.name))
		: [])
	let filteredCommands = $derived(sortedCommands.filter((commands) =>
		commands.name.toLowerCase().includes(search.toLowerCase())
	))
	let visibleCommands = $derived(filteredCommands.slice(0, visibleCount))

	function handleScroll(event) {
		const el = event.currentTarget
		if (el.scrollTop + el.clientHeight >= el.scrollHeight - 40) {
			visibleCount = Math.min(filteredCommands.length, visibleCount + pageSize)
		}
	}

	function handleSearch(value) {
		search = value
		visibleCount = pageSize
	}
</script>

<div class="h-full w-[33vh] px-[2vh]">
	<Header
		title={'Commands'}
		hasSearch={true}
		onSearchInput={event => handleSearch(event.target.value)}
	/>
	<div
		class="w-full h-[84%] flex flex-col gap-[1vh] mt-[1vh] overflow-auto"
		onscroll={handleScroll}
	>
		{#if $COMMANDS}
			{#if filteredCommands.length === 0}
				<div class="text-tertiary text-center text-[1.7vh] font-medium mt-[1vh]">No Commands Found.</div>
			{:else}
				<small class="font-medium">Total Commands: {filteredCommands.length}</small>
				{#each visibleCommands as commands (commands.name)}
					<CommandsCard label={commands.name} />
				{/each}
			{/if}
		{/if}
	</div>
</div>

{#if $MENU_WIDE}
	<div class="h-full w-[66vh] border-l-[0.2vh] border-tertiary px-[2vh]">
		<Header title={'Dashboard'} />
	</div>
{/if}
