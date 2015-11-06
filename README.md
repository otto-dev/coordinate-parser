# Coordinate Parser
## *Intelligent geographical coordinate parser in JavaScript*
Flexible algorithm to parse strings containing various latitude/longitude formats.

### Usage
```js
Coordinates = require('coordinate-parser');

position = new Coordinates('40:7:22.8N 74:7:22.8W');

latitude = position.getLatitude(); // 40.123 ✓
longitude = position.getLongitude(); // -74.123 ✓
```

### Supported formats
- `40.123, -74.123`
- `40.123° N 74.123° W`
- `40° 7´ 22.8" N 74° 7´ 22.8" W`
- `40° 7.38’ , -74° 7.38’`
- `N40°7’22.8, W74°7’22.8"`
- `40°7’22.8"N, 74°7’22.8"W`
- `40 7 22.8, -74 7 22.8`
- `40.123 -74.123`
- `40.123°,-74.123°`
- `144442800, -266842800`
- `40.123N74.123W`
- `4007.38N7407.38W`
- `40°7’22.8"N, 74°7’22.8"W`
- `400722.8N740722.8W`
- `N 40 7.38    W 74 7.38`
- `40:7:23N,74:7:23W`
- `40:7:22.8N 74:7:22.8W`
- `40°7’23"N 74°7’23"W`
- `40°7’23" -74°7’23"`
- `40d 7’ 23" N 74d 7’ 23" W`
- `40.123N 74.123W`
- `40° 7.38, -74° 7.38`

... and others that follow a similar pattern.

Handles also the following "exotic" formats:

- `145505994.48, -268708007.88` (*geographical milliseconds*)
- `4025.0999N7438.4668W` (*DDMM.xxxx*)
- `402505.994N743828.008W` (*DDMMSS.xxxx*)

### Coordinate validation
Input that does not resemble valid coordinates will throw an error.

The parser will detect invalid formats such as `40.123N FOOBAR 74.123W` (invalid characters), `40.123W 74.123N` (latitude/longitude exchanged) and `40.12  12.34  74.12` (odd numbers).

Flexibility towards non-alphanumeric characters and whitespaces is maintained.

```js
isValidPosition = function(position) {
  var error;
  var isValid;
  try {
    isValid = true;
    new Coordinates(position);
    return isValid;
  } catch (error) {
    isValid = false;
    return isValid;
  }
};

isCoordinate = isValidPosition('40:7:22.8N 74:7:22.8W'); // true
isCoordinate = isValidPosition('40.123 FOOBAR! 74.123'); // false
```

### Licence
This software is licensed under the Apache 2 license:
http://www.apache.org/licenses/LICENSE-2.0

Copyright (C) 2016 [WEPROG GmbH](http://www.weprog.com/)

### Credit
Originally developed for [WEPROG](http://www.weprog.com/) who kindly gave permission to open-source this code.
