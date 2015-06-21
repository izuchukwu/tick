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

Location: LLxxxx
Time Zone: TZxxxx