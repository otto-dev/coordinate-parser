Parser = require('../parser.coffee')
expect = require('chai').expect

expectation =
    result: [40.4183318, -74.6411133]
    formats: [
        "40.4183318, -74.6411133"
        "40.4183318° N 74.6411133° W"
        "40° 25´ 5.994\" N 74° 38´ 28.008\" W"
        "40° 25.0999’ , -74° 38.4668’"
        "N40°25’5.994, W74°38’28.008\""
        "40°25’5.994\"N, 74°38’28.008\"W"
        "40 25 5.994, -74 38 28.008"
        "40.4183318 -74.6411133"
        "40.4183318°,-74.6411133°"
        "145505994.48, -268708007.88"
        "40.4183318N74.6411133W"
        "4025.0999N7438.4668W"
        "40°25’5.994\"N, 74°38’28.008\"W"
        "402505.994N743828.008W"
        "N 40 25.0999    W 74 38.4668"
        "40:25:6N,74:38:28W"
        "40:25:5.994N 74:38:28.008W"
        "40°25’6\"N 74°38’28\"W"
        "40°25’6\" -74°38’28\""
        "40d 25’ 6\" N 74d 38’ 28\" W"
        "40.4183318N 74.6411133W"
        "40° 25.0999, -74° 38.4668"
    ]

reversedExpectation =
    result: [-40.4183318,74.6411133]
    formats: [
        "-40.4183318, 74.6411133"
        "40.4183318° S 74.6411133° E"
        "40° 25´ 5.994\" S 74° 38´ 28.008\" E"
        "-40° 25.0999’ , 74° 38.4668’"
        "S40°25’5.994, E74°38’28.008\""
        "40°25’5.994\"S, 74°38’28.008\"E"
        "-40 25 5.994, 74 38 28.008"
        "-40.4183318 74.6411133"
        "-40.4183318°,74.6411133°"
        "-145505994.48, 268708007.88"
        "40.4183318S74.6411133E"
        "4025.0999S7438.4668E"
        "40°25’5.994\"S, 74°38’28.008\"E"
        "402505.994S743828.008E"
        "S 40 25.0999    E 74 38.4668"
        "40:25:6S,74:38:28E"
        "40:25:5.994S 74:38:28.008E"
        "40°25’6\"S 74°38’28\"E"
        "-40°25’6\" 74°38’28\""
        "40d 25’ 6\" S 74d 38’ 28\" E"
        "40.4183318S 74.6411133E"
        "-40° 25.0999, 74° 38.4668"
    ]

invalidFormats = [
    "blablabla"
    "5 Fantasy street 12"
    "-40.1X, 74"
    "-40.1 X, 74"
    "-40.1, 74X"
    "-40.1, 74 X"
    "1 2 3 4 5 6 7 8"
    "1 2 3 4 5 6 7"
    "1 2 3 4 5"
    "1 2 3 "
    "1"
    "40.1° SS 60.1° EE"
    "40.1° E 60.1° S"
    "40.1° W 60.1° N"
    "40.1° W 60.1° W"
    "40.1° N 60.1° N"
    "-40.4183318, 12.345, 74.6411133"
]

describe "Parser", ->
    describe "fromString(coordinates)", ->
            
        it "converts strings correctly to decimal latitude/longitude", ->
            parser = new Parser

            for currentExpectation in [expectation, reversedExpectation]
                [expectedLatitude, expectedLongitude] = currentExpectation.result
                for format in currentExpectation.formats
                    [latitude, longitude] = parser.fromString(format)

                    try
                        expect(latitude).to.be.closeTo(expectedLatitude, 0.01)
                        expect(longitude).to.be.closeTo(expectedLongitude, 0.01)
                    catch error
                        console.log('Failed ', format)
                        console.log([latitude, longitude])
                        throw error
            
        
    describe "isValid(coordinates)", ->
        it "returns 'true' for valid coordinates strings, otherwise false", ->
            parser = new Parser
            for currentExpectation in [expectation, reversedExpectation]
                for format in currentExpectation.formats
                    isValid = parser.isValid(format)
                    try
                        expect(isValid).to.be.ok
                    catch error
                        console.log("Failed on correct format '#{format}'")
                        throw error

            for format in invalidFormats
                isValid = parser.isValid(format)
                try
                    expect(isValid).to.not.be.ok
                catch error
                    console.log("Failed on invalid format '#{format}'")
                    throw error
            
        
