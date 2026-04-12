import path from "path"
import { fileURLToPath } from "url"
import { malterlibCppHighlight } from "../src/cli/cmd/tui/query/malterlib-cpp"

const __filename = fileURLToPath(import.meta.url)
const __dirname = path.dirname(__filename)
const dir = path.resolve(__dirname, "..")

process.chdir(dir)

const modelsUrl = process.env.OPENCODE_MODELS_URL || "https://models.dev"
export const modelsData = process.env.MODELS_DEV_API_JSON
  ? await Bun.file(process.env.MODELS_DEV_API_JSON).text()
  : await fetch(`${modelsUrl}/api.json`).then((x) => x.text())
console.log("Loaded models.dev snapshot")

await Bun.write(path.join(dir, "src/cli/cmd/tui/query/malterlib-cpp.scm"), malterlibCppHighlight)
console.log("Generated malterlib-cpp.scm")
