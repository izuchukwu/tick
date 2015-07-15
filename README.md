# tick
A different kind of clock. News, meetings, & world time while you work or play.

## View Structure [Hold: Core]

`TKTickViewController` : `UICollectionViewController<TKClockworkStyleable>` (vertical)
- `TKNotificationViewController` : `UICollectionViewController<TKClockworkStyleable>` (horizontal)
 - `TKNotificationView` : `UIView<TKClockworkStyleable>`
- `TKClockViewController` : `UICollectionViewController<TKClockworkStyleable>` (horizontal)
 - `TKClocksView` : `UIView<TKClockworkStyleable>`
 - `TKClockView` : `UIView<TKClockworkStyleable>`
- `TKClockMetaView` : `UIView<TKClockworkStyleable>`


## Core (WIP)

### `TKClockwork` [Complete]
Styling manager dependency-injected into every custom view.

- Defines `@protocol TKClockworkStyleable`
- Defines `@protocol TKClockworkAuthority`

### `TKQuartz` [Complete]
Single NSTimer broadcasting to all time-interval-watching objects app-wide, notifying them to update their timekeeping.

### `TKClockStore` [Complete]
Queryable database of all clocks & time zones, plus user's selected clocks, dependency-injected where necessary.

### `TKClock` [Complete]
- Represents a single clock object
- Given by TKClockStore and consumed by TKClockView
- Defines `@protocol TKTimepiece`
- Special parameters for local (GPS) clock

### `TKUserDefaults` [Complete]
Serves as a class-method-based, block-based background thread wrapper for NSUserDefaults calls. Defines global defaults constants as well.

### `TKWeather` [Hold: `TKNotification`]
Fetches & stores conditions for a given clock (location-based only). Location API to be decided. If clock is the local clock, broadcasts internal notifications when weather changes.

### `TKWeatherCache` [Complete]
Stores location ID to weather ID mappings retreived from weather data source, as well as manages network retreival & caching of weather data fetches.

### `TKMusic` [Hold: `TKNotification`]
Listens for track change notifications to system's music player & re-broadcasts as internal notifications.

### `TKNotification` [Complete]
Has `const` key for internal notifications and also defines the internal notification payload structure.


## Custom Object Structure

### `TKClockworkStyle` [Complete]

- Style Title : `NSString`
- Primary Color : `UIColor`
- Accent Color : `UIColor`
- Secondhand Color : `UIColor`

### `TKClock` [Complete]

- Clock Title : `NSString`
- Time Zone : `NSTimeZone`
- Location : `CLLocation` (auto-approximated for non-location-based clocks)
- Weather : `TKWeather` (only available for location-based clocks)

### `TKWeather` [Complete]

- Current Conditions Data : `NSDictionary`

### `TKNotification` [Complete]

- Title : `NSString`
- Subtitle : `NSString` (displays under)
- Tag : `NSString` (displays over)
- Activity Icon : `UIImage`
- Image : `UIImage`
- Timestamp : `NSDate`


## Open Source Components

### BEMAnalogClock [To Be Added, CocoaPods]
The primary component in Tick’s centerpiece analog clock.

Developed by [Boris-Em](https://github.com/Boris-Em/BEMAnalogClock). [(License, MIT)](https://github.com/Boris-Em/BEMAnalogClock/blob/master/LICENSE)

### OAuth2Client [To Be Added, CocoaPods]
Used in establishing the OAuth connection to Feedly.

Developed by [nxtbgthng](https://github.com/nxtbgthng/OAuth2Client). [(License, BSD)](https://github.com/nxtbgthng/OAuth2Client#bsd-license)

### UAObfuscatedString [To Be Added, CocoaPods]
Used to encode Feedly client ID & secret in app binary.

Developed by [UrbanApps](https://github.com/UrbanApps/UAObfuscatedString). [(License, MIT)](https://github.com/UrbanApps/UAObfuscatedString/blob/master/LICENSE)

### US-State-Abbreviations [Added, Static (LC e423e8165a)]
Used to map US 2-letter state codes to full state names.

Developed by [Norman Harebottle III](https://github.com/normanhh3/US-State-Abbreviations). [(License, MIT)](https://github.com/normanhh3/US-State-Abbreviations/blob/master/LICENSE)


## Open Source Data

### GeoNames [Added]
The data source behind Tick's offline location database.

A project of [Unxos GmbH, Switzerland](http://www.geonames.org). [License, CC-BY 3.0](https://creativecommons.org/licenses/by/3.0/)

### Wikipedia [Added]
The data source behind Tick's offline time zone database.

Civilian time zones sourced from [Wikipedia — List of Time Zone Abbreviations](https://en.wikipedia.org/wiki/List_of_time_zone_abbreviations).
Military time zones sourced from [Wikipedia — List of Military Time Zones](https://en.wikipedia.org/wiki/List_of_military_time_zones).

A project supported by the [Wikimedia Foundation](https://en.wikipedia.org/wiki/Main_Page). [License, CC-BY-SA 3.0](https://creativecommons.org/licenses/by-sa/3.0/)


## APIs

### OpenWeatherMap [To Be Added, API]
The data API behind Tick's weather conditions & forecasting.

A service of [OpenWeatherMap Inc.](http://openweathermap.org). [License, CC-BY-SA 2.0](https://creativecommons.org/licenses/by-sa/2.0/)