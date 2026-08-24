# Frontend Sinaesta

## Perintah

`npm install`, `npm run dev`, `npm run build`, dan `npm run preview`.

Salin `.env.example` ke `.env`; variabel Vite hanya menyimpan URL API, tidak boleh berisi rahasia. Deploy direktori ini ke Vercel. `vercel.json` mengarahkan seluruh direct route ke `index.html`. Atur `VITE_API_BASE_URL=https://api.sinaesta.id/api`, domain dan metadata produksi di Vercel.

SPA memakai cookie session HttpOnly dan `withCredentials`; token CSRF readable-cookie dikirim sebagai header, tetapi autentikasi tidak disimpan di localStorage.
