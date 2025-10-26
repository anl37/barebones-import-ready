-- Fix critical security issues: restrict profiles and presence tables to authenticated users only

-- 1. Fix profiles table - require authentication for SELECT
DROP POLICY IF EXISTS profiles_select_all ON public.profiles;

CREATE POLICY profiles_select_authenticated ON public.profiles
  FOR SELECT TO authenticated
  USING (is_visible = true AND onboarded = true);

-- 2. Fix presence table - require authentication for SELECT  
DROP POLICY IF EXISTS presence_select_all ON public.presence;

CREATE POLICY presence_select_authenticated ON public.presence
  FOR SELECT TO authenticated
  USING (true);

-- Note: These changes prevent unauthenticated users from accessing user location data
-- Users must be logged in to see any profile or presence information