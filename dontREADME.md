# tick dont-readme
This is an internal living (parts of it, anyway) doc for getting down mental notes on internal structures. Nothing here is guaranteed to be up-to-date or what is actually implemented. Just a scratchpad.

## TKClockStore
bunch of location & time zone data

when queried for a listing it passes back a matching dictionary with:
- locations : NSDictionary
-- title : NSString
-- subtitle (locality, optional) : NSString
- timezones : NSDictionary
-- title : NSString
-- subtitle (abbreviation, optional) : NSString

also, the location stores are MASSIVE and need to be 1. loaded on-demand (lazily) and 2. purged after a period of inactivity (say 2m)

## TKClock

init with below vals & either UTCOffset : int or timeZoneIdentifier : NSString, both of which are internally converted to an NSTimeZone

- identifier : NSString
- title : NSString
- subtitle (optional) : NSString
- location : CLLocation
- timeZone : NSTimeZone

### identifier syntax

xxxx is disk store ID

Location [Primary]: LL1-xxxx
Location [Secondary]: LL1-xxxx
Time Zone [Primary]: TZ1-xxxx
Time Zone [Seondary]: TZ2-xxxx

## Pending Core Refactors

- All hard-coded `NSStrings` to `const`, esp `NSDictionary` keys & `TKClockStore` identifier prefixes
- Add OpenWeatherMap API Key to `initialize` in `TKWeatherCache`

## TKWeather

- Update current conditions based on lat/lon when clock is added & store ID
 - Lacks cache check (all requests remote)
 - Once per clock, cached by ID // not enforced
- Update batch current conditions by IDs every 15m
 - Results cached by ID for 15m // enforced by TKWeatherCache
- Update 3h forecast by ID on-demand per clock
 - Results cached by ID for 30m // enforced by TKWeatherCache
