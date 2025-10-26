-- Remove the restrictive check constraint on profiles.interests
-- This constraint was blocking new user signups because users start with empty interests array

ALTER TABLE public.profiles 
DROP CONSTRAINT IF EXISTS profiles_interests_len;

-- Optionally add a more lenient constraint if needed (commented out for now)
-- ALTER TABLE public.profiles 
-- ADD CONSTRAINT profiles_interests_max_len CHECK (array_length(interests, 1) IS NULL OR array_length(interests, 1) <= 20);