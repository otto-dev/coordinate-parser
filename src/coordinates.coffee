Validator = require('./validator')
CoordinateNumber = require('./coordinate-number')


class Coordinates
    constructor: (coordinateString, lonLatFormat)->
        @coordinates = coordinateString
        @latitudeNumbers = null
        @longitudeNumbers = null
        @lonLatFormat = lonLatFormat;
        @validate()
        @parse()


    validate: ()->
        validator = new Validator
        validator.validate(@coordinates, @lonLatFormat)


    parse: ->
        @groupCoordinateNumbers()
        @latitude = @extractLatitude()
        @longitude = @extractLongitude()


    groupCoordinateNumbers: () ->
        coordinateNumbers = @extractCoordinateNumbers(@coordinates)
        numberCountEachCoordinate = coordinateNumbers.length / 2
        @latitudeNumbers = if @lonLatFormat then coordinateNumbers[(0 - numberCountEachCoordinate)..] else coordinateNumbers[0...numberCountEachCoordinate]
        @longitudeNumbers = if @lonLatFormat then coordinateNumbers[0...numberCountEachCoordinate] else coordinateNumbers[(0 - numberCountEachCoordinate)..]


    extractCoordinateNumbers: (coordinates) ->
        return coordinates.match(/-?\d+(\.\d+)?/g)


    extractLatitude: ->
        latitude = @coordinateNumbersToDecimal(@latitudeNumbers)
        if @latitudeIsNegative()
            latitude = latitude * -1
        return latitude


    extractLongitude: ->
        longitude = @coordinateNumbersToDecimal(@longitudeNumbers)
        if @longitudeIsNegative()
            longitude = longitude * -1
        return longitude


    coordinateNumbersToDecimal: (coordinateNumbers) ->
        coordinate = new CoordinateNumber(coordinateNumbers)
        coordinate.detectSpecialFormats()
        decimalCoordinate = coordinate.toDecimal()
        return decimalCoordinate


    latitudeIsNegative: ->
         isNegative = @coordinates.match(/s/i)
         return isNegative


    longitudeIsNegative: ->
         isNegative = @coordinates.match(/w/i)
         return isNegative


    getLatitude: ->
        return @latitude


    getLongitude: ->
        return @longitude


module.exports = Coordinates
