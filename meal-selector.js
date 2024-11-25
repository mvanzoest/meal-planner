import fs from 'fs';

main().catch(console.error);

async function main() {
  const categories = await readCategories();
  console.log(categories);
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
