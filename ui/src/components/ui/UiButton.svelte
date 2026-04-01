<script lang="ts">
	import { tv, type VariantProps } from 'tailwind-variants'

	const buttonVariants = tv({
		base: 'relative inline-flex items-center justify-center gap-2 font-medium transition-colors duration-200 ease-in-out border-0 outline-0 outline-none cursor-pointer disabled:cursor-not-allowed disabled:opacity-50 focus:outline-0 focus:outline-none',
		variants: {
			variant: {
				primary: 'bg-primary text-white hover:bg-primary/90 rounded-[0.5vh]',
				secondary: 'bg-secondary text-white hover:bg-secondary/90 rounded-[0.5vh] border border-primary',
				icon: 'bg-transparent text-white hover:bg-tertiary rounded-[0.5vh]',
				row: 'w-full bg-tertiary text-white hover:bg-tertiary/90 rounded-[0.5vh] justify-start px-[1.5vh]'
			},
			size: {
				sm: 'h-[3vh] px-[1vh] text-[1.2vh]',
				md: 'h-[4vh] px-[1.5vh] text-[1.4vh]',
				lg: 'h-[4.5vh] px-[1.5vh] text-[1.5vh]'
			},
			loading: {
				true: 'cursor-wait opacity-75',
				false: ''
			},
			disabled: {
				true: 'cursor-not-allowed opacity-50',
				false: ''
			},
			hasTooltip: {
				true: `before:content-[attr(data-tip)] before:absolute before:-right-3 before:top-1/2 before:w-max before:max-w-xs before:px-[1vh] before:py-[0.5vh] before:-translate-x-full before:-translate-y-1/2 before:bg-tertiary before:text-white before:rounded-md before:opacity-0 before:transition-all before:z-50 after:absolute after:-right-3 after:top-1/2 after:-translate-x-0 after:-translate-y-1/2 after:h-0 after:w-0 after:border-t-transparent after:border-l-transparent after:border-b-transparent after:border-r-tertiary after:opacity-0 after:transition-all after:z-50 hover:before:opacity-100 hover:after:opacity-100`,
				false: ''
			}
		},
		compoundVariants: [
			// Special sizing for row variant
			{
				variant: 'row',
				size: 'sm',
				class: 'h-[3vh]'
			},
			{
				variant: 'row',
				size: 'md',
				class: 'h-[4vh]'
			},
			{
				variant: 'row',
				size: 'lg',
				class: 'h-[4.5vh]'
			},
			// Special sizing for icon variant
			{
				variant: 'icon',
				size: 'sm',
				class: 'w-[3vh] h-[3vh] p-0'
			},
			{
				variant: 'icon',
				size: 'md',
				class: 'w-[4vh] h-[4vh] p-0'
			},
			{
				variant: 'icon',
				size: 'lg',
				class: 'w-[5vh] h-[5vh] p-0'
			}
		],
		defaultVariants: {
			variant: 'primary',
			size: 'md',
			loading: false,
			disabled: false,
			hasTooltip: false
		}
	})

	type ButtonVariants = VariantProps<typeof buttonVariants>

	interface Props extends Omit<ButtonVariants, 'hasTooltip'> {
		type?: 'button' | 'submit' | 'reset'
		children?: import('svelte').Snippet
		onclick?: (event: MouseEvent) => void
		tooltipText?: string
	}

	let {
		variant = 'primary',
		size = 'md',
		disabled = false,
		loading = false,
		type = 'button',
		children,
		onclick = () => {},
		tooltipText
	} = $props<Props>()

	// Compute tooltip presence based on tooltipText
	let hasTooltip = $derived(!!tooltipText)
</script>

<button
	{type}
	{disabled}
	class={buttonVariants({ variant, size, loading, disabled, hasTooltip })}
	data-tip={tooltipText}
	onclick={(e) => {
		if (!disabled && !loading) {
			onclick(e)
		}
	}}
>
	{@render children?.()}
</button>
