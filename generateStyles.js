const fs = require('fs');
const hslMapStyle = require('hsl-map-style');
const tileserverGlConfig = require('./config.json');

const sourcesUrl = ["mbtiles://{openmaptiles}", "vector"];
const STYLES_FOLDER = tileserverGlConfig.options.paths.styles;

const queryParams = [
  {
    url: "https://api.digitransit.fi/", // Url pattern where the parameter should be added
    name: "digitransit-subscription-key",
    value: process.env.DIGITRANSIT_APIKEY,
  }
]

const mapStylesToGenerate = [
  {
    name: "hsl-map",
    sourcesUrl,
    queryParams,
    components: {
      simplified: { enabled: true }
    }
  },
  {
    name: "hsl-map-sv",
    sourcesUrl,
    queryParams,
    components: {
      simplified: { enabled: true },
      text_sv: { enabled: true }
    }
  },
  {
    name: "hsl-map-en",
    sourcesUrl,
    queryParams,
    components: {
      simplified: { enabled: true },
      text_en: { enabled: true }
    }
  },
  {
    name: "hsl-map-fi-sv",
    sourcesUrl,
    queryParams,
    components: {
      simplified: { enabled: true },
      text_fisv: { enabled: true }
    }
  },
  {
    name: "hsl-map-grayscale",
    sourcesUrl,
    queryParams,
    components: {
      greyscale: { enabled: true },
      simplified: { enabled: true },
      municipal_borders: { enabled: true }
    }
  }
];

// Generate HSL map styles into the map style folder defined in config.json 
mapStylesToGenerate.forEach(mapStyle => {
  const generatedMapStyle = hslMapStyle.generateStyle(mapStyle);
  fs.writeFileSync(__dirname + `/${STYLES_FOLDER}/${mapStyle.name}.json`, JSON.stringify(generatedMapStyle, null, 2), (err) => {
    if (err) return console.log(err);
  });
  console.log(`Successfully generated style ${mapStyle.name}`);
});

console.log('--- All styles generated ---');