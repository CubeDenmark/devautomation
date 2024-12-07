<template>
    <section class="text-white mt-18" id="about">
       Jenkins testing
    </section>
</template>
<script setup>
import { ref } from 'vue';

const education = ref([
    {
        id: 1,
        school: 'Tarlac State University',
        program: 'Software Development',
        year: '2020 - 2024',
    },
    {
        id: 2,
        school: 'School 2',
        program: 'Software Development',
        year: '2024 - 2026',
    },
])
</script>