declare module 'coordinate-parser' {
  class CoordinateParser {
    constructor(coordinateString: string);
    getLatitude(): number;
    getLongitude(): number;
  }

  module CoordinateParser {}

  export = CoordinateParser;
}

