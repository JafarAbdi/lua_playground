-- https://www.youtube.com/watch?v=86sgKa0jeO4&ab_channel=s1n7ax
-- https://tree-sitter.github.io/tree-sitter/using-parsers#query-syntax
local q = require("vim.treesitter.query")

function i(value)
  print(vim.inspect(value))
end

local bufnr = vim.api.nvim_get_current_buf()
local language_tree = vim.treesitter.get_parser(bufnr)
local syntax_tree = language_tree:parse()
local root = syntax_tree[1]:root()

local query = vim.treesitter.parse_query(
  "cpp",
  [[
(function_definition
  declarator: (function_declarator
    declarator: (qualified_identifier
      name: (identifier) @function_name
    ) @hola_mola
  )
)
]]
)

for id, match, metadata in query:iter_matches(root, bufnr) do
  for _, key in ipairs(match) do
    i(q.get_node_text(key, bufnr))
  end
  -- i(q.get_node_text(match[1], bufnr))
end
