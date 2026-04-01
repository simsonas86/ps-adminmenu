<script lang="ts">
	import { onMount } from "svelte"

    let { data } = $props();

    let favorite = $state(localStorage.getItem(`favorite-${data}`) === 'true');

    const toggleFavorite = () => {
        event.stopPropagation();
        favorite = !favorite;
        localStorage.setItem(`favorite-${data}`, favorite);
        // console.log(data, "is now", favorite ? "favorited" : "unfavorited");
    };

	onMount(() => {
		// console.log(data)
	})
</script>

<button 
    class="{favorite ? 'fas' : 'far'} fa-star"
    onclick={toggleFavorite}
>
</button>
