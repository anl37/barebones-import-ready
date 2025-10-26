-- Fix database functions to use fixed search_path

-- Fix generate_pair_id function to use fixed search_path
CREATE OR REPLACE FUNCTION public.generate_pair_id(user_a uuid, user_b uuid)
RETURNS text
LANGUAGE plpgsql
IMMUTABLE
SET search_path = public
AS $$
BEGIN
  -- Sort UUIDs to ensure consistent pair_id regardless of order
  IF user_a < user_b THEN
    RETURN user_a::TEXT || '_' || user_b::TEXT;
  ELSE
    RETURN user_b::TEXT || '_' || user_a::TEXT;
  END IF;
END;
$$;

-- Fix cleanup_stale_presence function to use fixed search_path
CREATE OR REPLACE FUNCTION public.cleanup_stale_presence()
RETURNS integer
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  deleted_count INTEGER;
BEGIN
  DELETE FROM public.presence
  WHERE updated_at < NOW() - INTERVAL '1 hour';
  
  GET DIAGNOSTICS deleted_count = ROW_COUNT;
  RETURN deleted_count;
END;
$$;