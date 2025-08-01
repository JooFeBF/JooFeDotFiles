return {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    opts = {
        workspaces = {
            {
                name = "joofe's vault",
                path = "~/JooFeVault/joofe's vault",
            },
        },
        ui = {
            enable = false,  -- Disable to avoid clash with render-markdown
        },
        completion = {
            nvim_cmp = true,
            min_chars = 2,
        },
        new_notes_location = "current_dir",
        note_id_func = function(title)
            return title
        end,
        note_frontmatter_func = function(note)
            local out = { id = note.id, aliases = note.aliases, tags = note.tags }
            if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
                for k, v in pairs(note.metadata) do
                    out[k] = v
                end
            end
            return out
        end,
        -- Enable Telescope integration
        finder = "telescope.nvim",
    },
    keys = {
        { "<leader>os", "<cmd>ObsidianQuickSwitch<cr>", desc = "Quick Switch" },
        { "<leader>oo", "<cmd>ObsidianOpen<cr>", desc = "Open Note" },
        { "<leader>on", "<cmd>ObsidianNew<cr>", desc = "New Note" },
        { "<leader>of", "<cmd>ObsidianSearch<cr>", desc = "Search Notes" },
        { "<leader>ot", "<cmd>ObsidianTags<cr>", desc = "Browse Tags" },
        { "<leader>ob", "<cmd>ObsidianBacklinks<cr>", desc = "Back Links" },
        { "<leader>ol", "<cmd>ObsidianFollowLink<cr>", desc = "Follow Link" },
        { "<leader>og", "<cmd>ObsidianGitSync<cr>", desc = "Git Sync" },
        { "<leader>oc", "<cmd>ToggleCheckboxX<cr>", desc = "Toggle Checkbox" },
    },
    config = function(_, opts)
        require("obsidian").setup(opts)
        
        -- Git sync command similar to Obsidian Git plugin
        vim.api.nvim_create_user_command("ObsidianGitSync", function()
            local vault_path = "~/JooFeVault/joofe\\'s\\ vault"
            vim.cmd("!cd " .. vault_path .. " && git pull && git add . && git commit -m 'Auto-sync: " .. os.date("%Y-%m-%d %H:%M:%S") .. "' && git push")
        end, {})
        
        -- Custom checkbox toggle that only toggles between [ ] and [x]
        vim.api.nvim_create_user_command("ToggleCheckboxX", function()
            local line = vim.api.nvim_get_current_line()
            local new_line
            
            if line:match("%- %[ %]") then
                -- Unchecked -> Checked
                new_line = line:gsub("%- %[ %]", "- [x]")
            elseif line:match("%- %[x%]") then
                -- Checked -> Unchecked
                new_line = line:gsub("%- %[x%]", "- [ ]")
            elseif line:match("^%s*%- ") then
                -- Plain bullet -> Unchecked checkbox
                new_line = line:gsub("^(%s*%- )", "%1[ ] ")
            else
                -- No change if not a list item
                return
            end
            
            vim.api.nvim_set_current_line(new_line)
        end, {})
    end,
}
