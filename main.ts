import * as cheerio from "cheerio";
import * as cli from "@std/cli";
import * as path from "@std/path";
import * as turndown from "turndown";

const args = cli.parseArgs(Deno.args, { string: ["from", "to"] });
const resume = path.join(import.meta.filename!, "..");
const from = path.join(path.isAbsolute(args.from) ? "/" : resume, args.from);
const to = path.join(path.isAbsolute(args.to) ? "/" : resume, args.to);

const $ = cheerio.load(await Deno.readTextFile(from));
$("body>header").prepend(
  $("<a/>").attr(
    "href",
    "https://raw.githack.com/alexander-matsievsky/resume/master/assets/resume.html",
  ).text("[HTML version]"),
  "&nbsp;",
  $("<a/>").attr(
    "href",
    "https://raw.githack.com/alexander-matsievsky/resume/master/assets/resume.pdf",
  ).text("[PDF version]"),
);
await Deno.writeTextFile(
  to,
  new turndown.default().remove(["style", "title"]).turndown($.html()),
);
