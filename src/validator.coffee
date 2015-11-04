class Validator
    isValid: (coordinates) ->
        isValid = yes
        try
            @validate(coordinates)
            return isValid
        catch validationError
            isValid = no
            return isValid


    validate: (coordinates) ->
        @checkContainsNoLetters(coordinates)
        @checkValidOrientation(coordinates)
        @checkNumbers(coordinates)


    checkContainsNoLetters: (coordinates) ->
        containsLetters = /(?![neswd])[a-z]/i.test(coordinates)
        if containsLetters
            throw new Error('Coordinate contains invalid alphanumeric characters.')


    checkValidOrientation: (coordinates) ->
        validOrientation = /^[^nsew]*[ns]?[^nsew]*[ew]?[^nsew]*$/i.test(coordinates)
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
