-- MedNova Partners Time Clock — Supabase Setup
-- Run this entire script once in your Supabase SQL Editor

-- EMPLOYEES
create table if not exists employees (
  id uuid primary key default gen_random_uuid(),
  employee_id text unique not null,
  first_name text not null,
  last_name text not null,
  password_hash text not null,
  runpayroll_num text,
  role text not null default 'employee', -- 'employee' or 'admin'
  active boolean not null default true,
  color int not null default 0,
  created_at timestamptz not null default now()
);

-- SHIFTS
create table if not exists shifts (
  id uuid primary key default gen_random_uuid(),
  employee_id text not null references employees(employee_id) on update cascade,
  clock_in timestamptz not null,
  clock_out timestamptz,
  created_at timestamptz not null default now()
);

-- EDIT HISTORY (audit log for admin edits)
create table if not exists edit_history (
  id uuid primary key default gen_random_uuid(),
  shift_id uuid not null references shifts(id),
  edited_by text not null,
  field_changed text not null,
  old_value text,
  new_value text,
  reason text,
  edited_at timestamptz not null default now()
);

-- INDEXES
create index if not exists idx_shifts_employee on shifts(employee_id);
create index if not exists idx_shifts_clock_in on shifts(clock_in);
create index if not exists idx_edit_history_shift on edit_history(shift_id);

-- ROW LEVEL SECURITY (disable for simplicity — app handles auth)
alter table employees disable row level security;
alter table shifts disable row level security;
alter table edit_history disable row level security;

-- SEED: Default admin account (password: admin123)
-- NOTE: In production replace 'admin123' with a strong password in the app settings
insert into employees (employee_id, first_name, last_name, password_hash, role, color)
values ('ADMIN', 'Admin', 'User', 'admin123', 'admin', 0)
on conflict (employee_id) do nothing;

-- SEED: Sample employees (password: pass123)
insert into employees (employee_id, first_name, last_name, password_hash, runpayroll_num, color)
values
  ('001', 'Maria', 'Garcia', 'pass123', '8', 0),
  ('002', 'James', 'Okafor', 'pass123', '9', 1),
  ('003', 'Sarah', 'Chen', 'pass123', '10', 2)
on conflict (employee_id) do nothing;
