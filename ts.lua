-- (function_definition
--   declarator: (function_declarator
--     parameters: (parameter_list
--                   (parameter_declaration
--                       type: (type_identifier) @gtest_suite_name)
--                   .
--                   (parameter_declaration 
--                       type: (type_identifier) @gtest_test_name))) @gtest_test
--   (#match? @gtest_test "TEST|TEST_F"))
local ts_utils = require("nvim-treesitter.ts_utils")
local ts = require("nvim-treesitter.textobjects.shared")
local query = [[(function_definition
  (function_declarator) @gtest
  (#match? @gtest "TEST|TEST_F")
)]]
local _, textobject = ts.textobject_at_point("@parameter.inner", { 127, 5 }, 1, {})
P(ts_utils.get_node_text(textobject, 1))
