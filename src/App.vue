<template>
   <div class="bg-[#343434] min-h-screen">
    <NavBar />
    <HeroSection />
    <ServicesSection />
    <AboutSection />
   </div>
</template>

<script setup>
import { defineAsyncComponent } from 'vue'
// Import components Asynchronously

const NavBar =  defineAsyncComponent(() => import('@/components/NavBar.vue'));
const HeroSection =  defineAsyncComponent(() => import('@/components/HeroSection.vue'));
const ServicesSection =  defineAsyncComponent(() => import('@/components/ServicesSection.vue'));
const AboutSection =  defineAsyncComponent(() => import('@/components/AboutSection.vue'));
</script>

