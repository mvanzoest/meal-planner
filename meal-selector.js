import fs from 'fs';
import config from './config.json' assert { type: 'json' };

main().catch(console.error);

async function main() {
  const settings = parseSettings();
  const categories = await readCategories();
  console.log(settings);
}

async function parseSettings() {
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
