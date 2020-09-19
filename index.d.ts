declare module 'coordinate-parser' {
    class Coordinates {
        constructor(coordinateString: string)
        getLatitude(): number
        getLongitude(): number
    }

    export default Coordinates
}
