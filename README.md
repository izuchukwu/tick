# tick
A different kind of clock. News, meetings, & world time while you work or play.

## View Structure
`TKTickViewController` : `UIScrollViewController<TKClockworkStyleable>` (vertical)
- `TKUpdateViewController` : `UIScrollViewController<TKClockworkStyleable>` (horizontal)
 - `TKUpdateView` : `UIView<TKClockworkStyleable>`
- `TKClockViewController` : `UIScrollViewController<TKClockworkStyleable>` (horizontal)
 - `TKClocksView` : `UIView<TKClockworkStyleable>`
 - `TKClockView` : `UIView<TKClockworkStyleable>`
- `TKClockMetaView` : `UIView<TKClockworkStyleable>`


## Core

### `TKClockwork` (WIP)
Styling manager dependency-injected into every custom view.

- Defines `@protocol TKClockworkStyleable`

### `TKQuartz` (WIP)
Single UITimer broadcasting to all time-interval-watching objects app-wide

### `TKClockStore` (WIP)
- Database of all clocks & time zones
- User’s clocks

### `TKClock` (WIP)
- Represents a single clock object
- Given by TKClockStore and consumed by TKClockView


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

