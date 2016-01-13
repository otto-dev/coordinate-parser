class CoordinateNumber
    constructor: (coordinateNumbers) ->
        coordinateNumbers = @normalizeCoordinateNumbers(coordinateNumbers)
        [@degrees, @minutes, @seconds, @milliseconds] = coordinateNumbers
        @sign = @normalizedSignOf(@degrees)
        @degrees = Math.abs(@degrees)


    normalizeCoordinateNumbers: (coordinateNumbers) ->
        normalizedNumbers = [0, 0, 0, 0]
        for currentNumber, i in coordinateNumbers
            normalizedNumbers[i] = parseFloat(currentNumber)
        return normalizedNumbers

    normalizedSignOf: (number) ->
        return if (number >= 0) then 1 else -1

    detectSpecialFormats: ->
        if @degreesCanBeSpecial()
            if @degreesCanBeMilliseconds()
                @degreesAsMilliseconds()
            else if @degreesCanBeDegreesMinutesAndSeconds()
                @degreesAsDegreesMinutesAndSeconds()
            else if @degreesCanBeDegreesAndMinutes()
                @degreesAsDegreesAndMinutes()


    degreesCanBeSpecial: ->
        canBe = no
        if not @minutes and not @seconds
            canBe = yes
        return canBe


    degreesCanBeMilliseconds: ->
        if @degrees > 909090
            canBe = yes
        else
            canBe = no
        return canBe


    degreesAsMilliseconds: ->
        @milliseconds = @degrees
        @degrees = 0


    degreesCanBeDegreesMinutesAndSeconds: ->
        if @degrees > 9090
            canBe = yes
        else
            canBe = no
        return canBe


    degreesAsDegreesMinutesAndSeconds: ->
        newDegrees = Math.floor(@degrees / 10000)
        @minutes = Math.floor((@degrees - newDegrees * 10000) / 100)
        @seconds = Math.floor(@degrees - newDegrees * 10000 - @minutes * 100)
        @degrees = newDegrees


    degreesCanBeDegreesAndMinutes: ->
        if @degrees > 360
            canBe = yes
        else
            canBe = no
        return canBe


    degreesAsDegreesAndMinutes: ->
        newDegrees = Math.floor(@degrees / 100)
        @minutes = @degrees - newDegrees * 100
        @degrees = newDegrees


    toDecimal: ->
        decimalCoordinate = @sign * (@degrees + @minutes / 60 + @seconds / 3600 + @milliseconds / 3600000)
        return decimalCoordinate


module.exports = CoordinateNumber
