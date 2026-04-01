<script>
	import { ACTIVE_PAGE, DEV_MODE, MENU_WIDE } from '@store/stores'
	import UiButton from '@components/ui/UiButton.svelte'
	import UiToggle from '@components/ui/UiToggle.svelte'
	import { SendNUI } from '@utils/SendNUI'
	import UiToggleGroup from '@components/ui/UiToggleGroup.svelte'

	let navigation = [
		{ value: 'Staffchat', icon: 'fas fa-message' },
		{ value: 'Players', icon: 'fas fa-users' },
		{ value: 'Server', icon: 'fas fa-server' },
		{ value: 'Commands', icon: 'fas fa-slash' },
		{ value: 'Actions', icon: 'fas fa-wand-magic-sparkles' },
	]

	$inspect('Active page: ', $ACTIVE_PAGE)
	$inspect('Dev mode: ', $DEV_MODE)
	$inspect('Menu wide: ', $MENU_WIDE)
</script>

<div
	class="w-[7vh] h-full flex flex-col gap-y-[1vh] items-center py-[1.4vh] border-r-[0.2vh] border-tertiary"
>
	<div class="mb-auto">
		<UiButton
			variant="icon"
			size="md"
			onclick={() => MENU_WIDE.update((wide) => !wide)}
		>
			<i
				class="fas"
				class:fa-angle-right={$MENU_WIDE}
				class:fa-angle-left={!$MENU_WIDE}
			></i>
		</UiButton>
	</div>

	<UiToggleGroup
		bind:value={$ACTIVE_PAGE}
		type="single"
		orientation="vertical"
		onChange={(value) => {
			ACTIVE_PAGE.set(value)
			SendNUI('clickButton', { data: String(value).toLowerCase() })
		}}
	>
		{#snippet children({ value, selectValue, isSelected })}
			{#each navigation as nav}
				<UiToggle
					variant="icon"
					size="md"
					pressed={isSelected(nav.value)}
					onclick={() => selectValue(nav.value)}
					tooltipText={nav.value}
				>
					<i class={nav.icon}></i>
				</UiToggle>
			{/each}
		{/snippet}
	</UiToggleGroup>

	<UiToggle
		variant="icon"
		size="md"
		pressed={$DEV_MODE}
		tooltipText="Dev Mode"
		onclick={() => {
			DEV_MODE.update((dev) => !dev)
			SendNUI('clickButton', {
				data: 'toggleDevmode',
			})
		}}
	>
		<i class="fas fa-code"></i>
	</UiToggle>
</div>
