local Path = require("plenary.path")

local targets = vim.fn.system([[make -pRrq : 2>/dev/null |
    awk -F: '/^# Files/,/^# Finished Make data base/ {
        if ($1 == "# Not a target") skip = 1;
        if ($1 !~ "^[#.\t]") { if (!skip) print $1; skip=0 }
    }'
]])

targets = vim.split(targets, "\n", { trimempty = true })
targets = vim.tbl_filter(function(e)
  return e ~= ""
end, targets)

P(targets)
