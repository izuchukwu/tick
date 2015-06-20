# tick
A different kind of clock. News, meetings, & world time while you work or play.

## View Structure
`TKTickViewController` : `UIScrollViewController` (vertical)
- `TKUpdateViewController` : `UIScrollViewController` (horizontal)
— `TKUpdateView` : `UIView`
- `TKClockViewController` : `UIScrollViewController` (horizontal)
— `TKClocksView` : `UIView`
— `TKClockView` : `UIView`
- `TKClockMetaView` : `UIView`

## Backend

### `TKQuartz`
Single UITimer broadcasting to all time-interval-watching objects app-wide

### `TKClockStore`
- Database of all clocks & time zones
- User’s clocks

### `TKClock`
- Represents a single clock object
- Given by TKClock and consumed by TKClockView

## Open Source Components

### BEMAnalogClock
The primary component in Tick’s centerpiece analog clock.
Developed by [Boris-Em](https://github.com/Boris-Em/BEMAnalogClock)
[License (MIT)](https://github.com/Boris-Em/BEMAnalogClock/blob/master/LICENSE)

### OAuth2Client
Used in establishing the OAuth connection to Feedly.
Developed by [nxtbgthng](https://github.com/nxtbgthng/OAuth2Client)
[License (BSD)](https://github.com/nxtbgthng/OAuth2Client#bsd-license)

### UAObfuscatedString
Used to encode Feedly client ID & secret in app binary.
Developed by [UrbanApps](https://github.com/UrbanApps/UAObfuscatedString)
[License (MIT)](https://github.com/UrbanApps/UAObfuscatedString/blob/master/LICENSE)

