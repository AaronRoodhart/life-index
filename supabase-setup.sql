create table life_index (
  user_id uuid references auth.users(id) primary key,
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table life_index enable row level security;

create policy "Users can view own data" on life_index
  for select using (auth.uid() = user_id);

create policy "Users can insert own data" on life_index
  for insert with check (auth.uid() = user_id);

create policy "Users can update own data" on life_index
  for update using (auth.uid() = user_id);
