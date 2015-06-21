# tick
A different kind of clock. News, meetings, & world time while you work or play.

## View Structure
`TKTickViewController` : `UICollectionViewController<TKClockworkStyleable>` (vertical)
- `TKUpdateViewController` : `UICollectionViewController<TKClockworkStyleable>` (horizontal)
 - `TKUpdateView` : `UIView<TKClockworkStyleable>`
- `TKClockViewController` : `UICollectionViewController<TKClockworkStyleable>` (horizontal)
 - `TKClocksView` : `UIView<TKClockworkStyleable>`
 - `TKClockView` : `UIView<TKClockworkStyleable>`
- `TKClockMetaView` : `UIView<TKClockworkStyleable>`


## Core

### `TKClockwork` [Complete]
Styling manager dependency-injected into every custom view.

- Defines `@protocol TKClockworkStyleable`

### `TKQuartz` [Complete]
Single NSTimer broadcasting to all time-interval-watching objects app-wide, notifying them to update their timekeeping.

### `TKClockStore` [Complete]
Queryable database of all clocks & time zones, plus user's selected clocks, dependency-injected where necessary.
- *To add method* `addClockToUserStore:`, `TKClock` *must be implemented*

### `TKClock` [Complete]
- Represents a single clock object
- Given by TKClockStore and consumed by TKClockView

### `TKUserDefaults` (WIP)
Serves as a class-method-based, block-based background thread wrapper for NSUserDefaults calls. Defines global defaults constants as well.


## Custom Object Structure

### `TKClockworkStyle` [Complete]

- Style Title : `NSString`
- Primary Color : `UIColor`
- Accent Color : `UIColor`
- Secondhand Color : `UIColor`

### `TKClock` (WIP)

- Clock Title : `NSString`
- Time Zone : `NSTimeZone`
- Location : `CLLocation`
- Weather : `TKWeather`

### `TKWeather` (WIP)

- Current Conditions Title : `NSString`
- Current Conditions Temperature : `NSNumber` (int)
- Current Conditions Icon : `UIImage`


## Open Source Components

### BEMAnalogClock
The primary component in Tick’s centerpiece analog clock.

Developed by [Boris-Em](https://github.com/Boris-Em/BEMAnalogClock). [(License, MIT)](https://github.com/Boris-Em/BEMAnalogClock/blob/master/LICENSE)

### OAuth2Client
Used in establishing the OAuth connection to Feedly.

Developed by [nxtbgthng](https://github.com/nxtbgthng/OAuth2Client). [(License, BSD)](https://github.com/nxtbgthng/OAuth2Client#bsd-license)

### UAObfuscatedString
Used to encode Feedly client ID & secret in app binary.

Developed by [UrbanApps](https://github.com/UrbanApps/UAObfuscatedString). [(License, MIT)](https://github.com/UrbanApps/UAObfuscatedString/blob/master/LICENSE)

### US-State-Abbreviations
Used to map US 2-letter state codes to full state names.

Developed by [Norman Harebottle III](https://github.com/normanhh3/US-State-Abbreviations). [(License, MIT)](https://github.com/normanhh3/US-State-Abbreviations/blob/master/LICENSE)

