-- Allow users to SELECT their own profile regardless of onboarding status
CREATE POLICY "profiles_select_self"
ON public.profiles
FOR SELECT
TO authenticated
USING (auth.uid() = id);

-- Update the existing authenticated select policy to not block users from seeing their own profiles
DROP POLICY IF EXISTS "profiles_select_authenticated" ON public.profiles;

CREATE POLICY "profiles_select_authenticated"
ON public.profiles
FOR SELECT
TO authenticated
USING (
  (auth.uid() = id) OR ((is_visible = true) AND (onboarded = true))
);