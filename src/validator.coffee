class Validator
    isValid: (coordinates, lonLatFormat) ->
        isValid = yes
        try
            @validate(coordinates, lonLatFormat)
            return isValid
        catch validationError
            isValid = no
            return isValid


    validate: (coordinates, lonLatFormat) ->
        @checkContainsNoLetters(coordinates)
        @checkValidOrientation(coordinates, lonLatFormat)
        @checkNumbers(coordinates)


    checkContainsNoLetters: (coordinates) ->
        containsLetters = /(?![neswd])[a-z]/i.test(coordinates)
        if containsLetters
            throw new Error('Coordinate contains invalid alphanumeric characters.')

    checkValidOrientation: (coordinates, lonLatFormat) ->
        validOrientation = if lonLatFormat then /^[^nsew]*[ew]?[^nsew]*[ns]?[^nsew]*$/i.test(coordinates) else /^[^nsew]*[ns]?[^nsew]*[ew]?[^nsew]*$/i.test(coordinates)
        if not validOrientation
            throw new Error('Invalid cardinal direction.')

    checkNumbers: (coordinates) ->
        coordinateNumbers = coordinates.match(/-?\d+(\.\d+)?/g)
        @checkAnyCoordinateNumbers(coordinateNumbers)
        @checkEvenCoordinateNumbers(coordinateNumbers)
        @checkMaximumCoordinateNumbers(coordinateNumbers)


    checkAnyCoordinateNumbers: (coordinateNumbers) ->
        if coordinateNumbers.length is 0
            throw new Error('Could not find any coordinate number')


    checkEvenCoordinateNumbers: (coordinateNumbers) ->
        isUnevenNumbers = coordinateNumbers.length % 2
        if isUnevenNumbers
            throw new Error('Uneven count of latitude/longitude numbers')


    checkMaximumCoordinateNumbers: (coordinateNumbers) ->
        if coordinateNumbers.length > 6
            throw new Error('Too many coordinate numbers')


module.exports = Validator
