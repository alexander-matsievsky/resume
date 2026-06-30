import * as cli from "@std/cli";
import * as path from "@std/path";
import * as cheerio from "cheerio";
import * as turndown from "turndown";

const args = cli.parseArgs(Deno.args, { string: ["from", "to"] });
const from = path.isAbsolute(args.from) ? args.from : path.join(import.meta.filename!, "..", args.from);
const to = path.isAbsolute(args.to) ? args.to : path.join(import.meta.filename!, "..", args.to);

const $ = cheerio.load(await Deno.readTextFile(from));
$("body>header").prepend(
  $(`<a href="https://raw.githack.com/alexander-matsievsky/resume/master/assets/resume.html">[HTML version]</a>`),
  "&nbsp;",
  $(`<a href="https://raw.githack.com/alexander-matsievsky/resume/master/assets/resume.pdf">[PDF version]</a>`),
);
await Deno.writeTextFile(
  to,
  new turndown.default().remove(["style", "title"]).turndown($.html()),
);
