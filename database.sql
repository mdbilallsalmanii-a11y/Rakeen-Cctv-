-- RAKEEN Supabase database setup
create extension if not exists pgcrypto;

create table if not exists public.products (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  price numeric not null,
  category text,
  icon text,
  description text,
  created_at timestamptz not null default now()
);

create table if not exists public.appointments (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  phone text not null,
  date date not null,
  time time not null,
  service text not null,
  cameras text,
  address text not null,
  created_at timestamptz not null default now()
);

alter table public.products enable row level security;
alter table public.appointments enable row level security;

-- Public customers can view products.
create policy "products public read" on public.products
for select to anon, authenticated using (true);

-- Public customers can submit appointments.
create policy "appointments public insert" on public.appointments
for insert to anon, authenticated with check (true);

-- IMPORTANT:
-- The simple demo admin panel in this package uses the browser anon key.
-- Before a real public launch, replace the demo password gate with Supabase Auth
-- and restrict product INSERT/UPDATE/DELETE and appointment SELECT to an admin role.
