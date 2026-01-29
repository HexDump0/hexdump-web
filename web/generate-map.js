const fs = require('fs');
const DottedMap = require('dotted-map').default;

const map = new DottedMap({
  height: 75,
  grid: 'diagonal',
});

const points = map.getPoints();

points.forEach((point) => {
  if (Math.random() < 0.01) {
    point.svgOptions = { color: '#FFFFFF', radius: 0.22 };
  }
});

const svgMap = map.getSVG({
  radius: 0.22,
  color: 'rgba(255, 255, 255, 0.2)',
  shape: 'circle',
  backgroundColor: 'transparent',
});

fs.writeFileSync('./map.svg', svgMap);
console.log('Map generated: map.svg');
