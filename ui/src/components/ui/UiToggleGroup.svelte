<script lang="ts">
	export type ToggleGroupOrientation = 'horizontal' | 'vertical'
	export type ToggleGroupType = 'single' | 'multiple'

	interface ToggleGroupSlotProps {
		value: string | number | Array<string | number>
		selectValue: (value: string | number) => void
		isSelected: (value: string | number) => boolean
	}

	interface Props {
		value?: string | number | Array<string | number>
		orientation?: ToggleGroupOrientation
		type?: ToggleGroupType
		children?: import('svelte').Snippet<ToggleGroupSlotProps>
		onChange?: (value: string | number | Array<string | number>) => void
	}

	let {
		value = $bindable(''),
		orientation = 'horizontal',
		type = 'single',
		children,
		onChange = () => {}
	} = $props<Props>()

	function isSelected(checkValue: string | number): boolean {
		if (type === 'single') {
			return value === checkValue
		}

		return Array.isArray(value) && value.includes(checkValue)
	}

	function selectValue(newValue: string | number) {
		if (type === 'single') {
			value = newValue
			onChange(newValue)
			return
		}

		const currentValues = Array.isArray(value) ? [...value] : []
		const index = currentValues.indexOf(newValue)

		if (index === -1) {
			currentValues.push(newValue)
		} else {
			currentValues.splice(index, 1)
		}

		value = currentValues
		onChange(currentValues)
	}
</script>

<div
	class="inline-flex gap-2"
	class:items-start={orientation === 'vertical'}
	class:flex-col={orientation === 'vertical'}
	class:flex-row={orientation === 'horizontal'}
>
	{#if children}
		{@render children?.({ value, selectValue, isSelected })}
	{:else}
		{@render children?.({ value, selectValue, isSelected })}
	{/if}
</div>
