/** @type {import('tailwindcss').Config} */
export default {
  content: ['./index.html', './src/**/*.{vue,js,ts,jsx,tsx}'],
  theme: {
    extend: {
      colors: {
        primary: '#055E68',
        secondary: '#ec4899',
        end: '#62A388'
      }
    },
  },
  plugins: [],
}

