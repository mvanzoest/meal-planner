import fs from 'fs';
import config from './config.json' with { type: 'json' };

main().catch(console.error);

/**
 * Example usage: node meal-selector.js -m 2 -s 2 -d 1
 * -m 2: Select 2 main courses
 * -s 2: Select 2 side dishes
 * -d 1: Select 1 dessert
 */
async function main() {
  const settings = parseSettings();
  const categories = await readCategories();
  const selections = selectPages(categories, settings);
  console.log(selections);
}

function selectPages(categories, settings) {
  const buckets = constructBuckets(categories);
  const selections = makeSelections(settings, buckets);
  return selections;
}

function makeSelections(settings, buckets) {
  const selections = [];
  for (const setting of settings) {
    const bucket = buckets[setting.category];
    if (!bucket) {
      throw new Error(`Invalid category: ${setting.category}`);
    }
    for (let i = 0; i < setting.count; i++) {
      const randomNumber = Math.floor(Math.random() * Object.keys(bucket).length);
      const page = Object.keys(bucket)[randomNumber];
      const sections = bucket[page];
      selections.push({category: setting.category, page, sections});
    }
  }
  return selections;
}

function constructBuckets(categories) {
  const buckets = {};
  for (const category of categories) {
    if (!buckets[category.name]) {
      buckets[category.name] = {};
    }
    const bucket = buckets[category.name];
    for (const section of category.sections) {
      for (let i = section.start; i <= section.end; i++) {
        if (!bucket[i]) {
          bucket[i] = [section.name];
        } else {
          bucket[i].push(section.name);
        }
      }
    }
  }
  return buckets;
}

function parseSettings() {
  const args = process.argv.slice(2);
  if (args.length === 0) {
    throw new Error('No arguments provided');
  }
  const settings = [];
  for (let i = 0; i < args.length; i+=2) {
    if (!args[i].startsWith('-') || args[i].length !== 2) {
      throw new Error(`Invalid argument: ${args[i]}`);
    }
    const category = config.args[args[i][1]];
    if (!category) {
      throw new Error(`Invalid argument: ${args[i]}`);
    }
    if (!args[i + 1]) {
      throw new Error(`Missing argument value: ${args[i]}`);
    }
    const count = Number.parseInt(args[i + 1]);
    if (isNaN(count)) {
      throw new Error(`Invalid argument value: ${args[i + 1]}`);
    }
    settings.push({category, count});
  }
  return settings;
}

async function readCategories() {
  const content = await fs.promises.readFile('recipe-sections.txt', 'utf-8');
  const lines = content.split('\n');
  const categories = [];
  let currentCategory = null;
  for (const line of lines) {
    if (!currentCategory) {
      currentCategory = {
        name: line.trim(),
        sections: [],
      };
    } else if (/^\s*$/.test(line)) {
      categories.push(currentCategory);
      currentCategory = null;
    } else {
      const section = parseLine(line);
      currentCategory.sections.push(section);
    }
  }
  return categories;
}

/**
 * 
 * @param {string} line 
 * @returns 
 */
function parseLine(line) {
  const nameIndexStart = line.startsWith('"') ? 1 : 0;
  const nameIndexEnd = line.startsWith('"') ? line.indexOf('"', 1) : line.indexOf(',');
  const name = line.slice(nameIndexStart, nameIndexEnd);
  const rest = line.slice(nameIndexEnd + 1 + nameIndexStart);
  const tokens = rest.split(',');
  if (!name || tokens.length !== 2) {
    throw new Error(`Invalid line: ${line}`);
  }
  const start = Number.parseInt(tokens[0].trim());
  const end = Number.parseInt(tokens[1].trim());
  if (isNaN(start) || isNaN(end)) {
    throw new Error(`Invalid line: ${line}`);
  }
  return {name, start, end};
}
