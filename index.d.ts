declare module 'coordinate-parser' {
    class CoordinateParser {
        constructor(coordinateString: string)
        getLatitude(): number
        getLongitude(): number
        isValidPosition(): boolean
    }

    export default CoordinateParser
}
