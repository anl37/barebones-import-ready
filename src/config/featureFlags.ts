/**
 * Feature flags for Spotmate
 * Control experimental features and debug modes
 */

export const FEATURE_FLAGS = {
  /**
   * Background location is ALWAYS ON by default
   * When users grant location permission, continuous tracking starts immediately
   * This is independent of "Connect" visibility status
   */
  backgroundLocation: true,
  
  /**
   * Enable detailed console logging for presence updates
   * Useful for debugging location tracking and matching
   */
  debugPresenceLogging: true,
  
  /**
   * Use mock location (Durham, NC) when running in non-HTTPS environment
   * Production apps on HTTPS will use real geolocation
   */
  mockLocationInHttp: true,
  
  /**
   * Geohash precision level (1-12)
   * 7 = ~150m squares (good for ~10-15m proximity matching)
   */
  geohashPrecision: 7,
  
  /**
   * Maximum distance in meters to consider a match
   * Default: 15m (~50 feet)
   */
  maxMatchDistanceMeters: 15,
  
  /**
   * Throttle settings for location updates
   */
  locationThrottle: {
    // Minimum meters moved before publishing
    minDisplacementMeters: 25,
    
    // Minimum seconds between updates (moving)
    minIntervalMovingSeconds: 60,
    
    // Minimum seconds between updates (stationary)
    minIntervalStationarySeconds: 180,
    
    // Consider stationary if speed < this (m/s)
    stationarySpeedThreshold: 0.5,
  },
};

/**
 * Get current feature flag configuration
 */
export function getFeatureFlags() {
  return FEATURE_FLAGS;
}

/**
 * Check if a feature is enabled
 */
export function isFeatureEnabled(feature: keyof typeof FEATURE_FLAGS): boolean {
  return Boolean(FEATURE_FLAGS[feature]);
}
