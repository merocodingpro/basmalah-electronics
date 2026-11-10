-- ========================================================
-- سنتر بسملة للأجهزة الكهربائية - سكيما قاعدة بيانات Supabase
-- ========================================================

-- 1. جدول الأقسام
CREATE TABLE IF NOT EXISTS categories (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  slug TEXT UNIQUE NOT NULL,
  description TEXT,
  image TEXT
);

-- 2. جدول المنتجات
CREATE TABLE IF NOT EXISTS products (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  category TEXT NOT NULL,
  price NUMERIC NOT NULL,
  original_price NUMERIC,
  description TEXT,
  features JSONB DEFAULT '[]'::jsonb,
  specs JSONB DEFAULT '{}'::jsonb,
  images JSONB DEFAULT '[]'::jsonb,
  in_stock BOOLEAN DEFAULT TRUE,
  stock_count INTEGER DEFAULT 0,
  is_featured BOOLEAN DEFAULT FALSE,
  is_offer BOOLEAN DEFAULT FALSE,
  is_active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 3. جدول مناطق التوصيل
CREATE TABLE IF NOT EXISTS delivery_areas (
  id TEXT PRIMARY KEY,
  governorate TEXT NOT NULL,
  area_name TEXT NOT NULL,
  delivery_fee NUMERIC NOT NULL DEFAULT 0,
  duration_days TEXT DEFAULT 'خلال 2 إلى 3 أيام',
  is_active BOOLEAN DEFAULT TRUE
);

-- 4. جدول الطلبات
CREATE TABLE IF NOT EXISTS orders (
  id TEXT PRIMARY KEY,
  order_number TEXT UNIQUE NOT NULL,
  customer_name TEXT NOT NULL,
  customer_phone TEXT NOT NULL,
  governorate TEXT NOT NULL,
  area TEXT NOT NULL,
  address TEXT NOT NULL,
  notes TEXT,
  items JSONB NOT NULL,
  total_amount NUMERIC NOT NULL,
  delivery_fee NUMERIC NOT NULL DEFAULT 0,
  grand_total NUMERIC NOT NULL,
  status TEXT DEFAULT 'new', -- new, contacted, shipping, delivered, cancelled
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- الفهارس لتحسين الأداء
CREATE INDEX IF NOT EXISTS idx_products_category ON products(category);
CREATE INDEX IF NOT EXISTS idx_products_is_active ON products(is_active);
CREATE INDEX IF NOT EXISTS idx_orders_status ON orders(status);
CREATE INDEX IF NOT EXISTS idx_orders_created_at ON orders(created_at DESC);
