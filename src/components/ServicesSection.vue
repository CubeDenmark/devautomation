<template>
    <section class="text-white mt-20" id="services">
        
            <div v-for="service in services" :key="service.id" data-aos="fade-up"
            class="px-8 py-12 rounded-xl bg-[#2d2d2d] shadow-lg border border-[#2d2d2d]"
            >
                <div class="mx-auto h-24 text-center xl:h-28 xl:w-28">
                    <div>
                        <img :src="service.icon" alt="service icon">
                    </div>
                </div>
                <div class="text-center">
                    <h3 class="pt-8 text-lg font-semibold uppercase text-transparent bg-clip-text bg-gradient-to-r from-primary to-end lg:text-xl">
                        {{ service.name }}
                    </h3>
                    <p class="text-gray pt-4 text-sm group-hover:text-white md:text-base">
                        {{ service.description }}
                    </p>
                </div>
            </div>
    </section>
</template>
<script setup>
import { ref } from 'vue';
const services =ref([
    {
        id:1,
        icon:'https://img.icons8.com/ios-filled/100/ffffff/google-code.png',
        name:'WEB DEVELOPMENT',
        description:'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Dicta, ut!'
    },
    {
        id:2,
        icon:'https://img.icons8.com/external-vectorslab-glyph-vectorslab/100/fffeee/external-Technical-Writing-mobile-app-development-vectorslab-glyph-vectorslab.png',
        name:'Technical Writing',
        description:'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Dicta, ut!'
    },
    {
        id:3,
        icon:'https://img.icons8.com/external-solid-design-circle/100/ffffff/external-Mobile-Development-digital-marketing-solid-design-circle.png',
        name:'Mobile Development',
        description:'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Dicta, ut!'
    },
    {
        id:4,
        icon:'https://img.icons8.com/ios-filled/100/ffffff/email-open.png',
        name:'WEB DEVELOPMENT',
        description:'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Dicta, ut!'
    },
    {
        id:5,
        icon:'https://img.icons8.com/ios-filled/100/ffffff/windows10-personalization.png',
        name:'Graphic Design',
        description:'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Dicta, ut!'
    },
    {
        id:6,
        icon:'https://img.icons8.com/ios-filled/100/ffffff/web-design.png',
        name:'Web Design',
        description:'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Dicta, ut!'
    },
    ])
</script>