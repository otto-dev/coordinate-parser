class Parser
    fromString: (coordinatesString) ->
        coordinatesParts = coordinatesString.match(/-?\d+(\.\d+)?/g)
        isUnevenParts = coordinatesParts.length % 2
        if isUnevenParts
            throw new Error('Uneven count of latitude/longitude numbers')
        if coordinatesParts.lenght is 0
            throw new Error('Could not find any coordinate number')
        if coordinatesParts.lenght > 6
            throw new Error('Too many coordinate numbers')

        coordinatePartCount = coordinatesParts.length / 2
        latitudeParts = coordinatesParts[0...coordinatePartCount]
        longitudeParts = coordinatesParts[(0 - coordinatePartCount)..]
        latitude = @partsToDecimal(latitudeParts)
        longitude = @partsToDecimal(longitudeParts)


        latitudeIsNegative = coordinatesString.match(/s|S/)
        longitudeIsNegative = coordinatesString.match(/w|W/)
        if latitudeIsNegative
            latitude = latitude * -1
        if longitudeIsNegative
            longitude = longitude * -1
        return [latitude, longitude]


    partsToDecimal: (coordinateParts) ->
        [degrees, minutes, seconds] = (parseFloat part for part in coordinateParts)
        minutes ?= 0
        seconds ?= 0
        milliseconds = 0


        sign = Math.sign(degrees)
        degrees = Math.abs(degrees)
        if not minutes and not seconds
            if degrees > 909090
                milliseconds = degrees
                degrees = 0
            if degrees > 9090
                newDegrees = Math.floor(degrees / 10000)
                minutes = Math.floor((degrees - newDegrees * 10000) / 100)
                seconds = Math.floor(degrees - newDegrees * 10000 - minutes * 100)
                degrees = newDegrees

            if degrees > 360
                newDegrees = Math.floor(degrees / 100)
                minutes = degrees - newDegrees * 100
                degrees = newDegrees

        decimalCoordinate = sign * (degrees + minutes / 60 + seconds / 3600 + milliseconds / 3600000)
        return decimalCoordinate

module.exports = Parser
