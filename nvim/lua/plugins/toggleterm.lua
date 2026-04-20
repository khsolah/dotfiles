return {
  "akinsho/toggleterm.nvim",
  version = "*",
  opts = {
    size = 20,
    open_mapping = nil, -- 不用預設 mapping
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = false,
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true,
    persist_size = true,
    persist_mode = true,
    close_on_exit = false, -- ❗關鍵：不要關掉 process
    direction = "float",
    float_opts = {
      border = "rounded",
      width = function()
        return math.floor(vim.o.columns * 0.9)
      end,
      height = function()
        return math.floor(vim.o.lines * 0.9)
      end,
      winblend = 10,
    },
  },
  config = function(_, opts)
    require("toggleterm").setup(opts)

    local Terminal = require("toggleterm.terminal").Terminal

    -- =========================
    -- 🎛️ UI MODES
    -- =========================

    local ui_modes = {
      center = {
        direction = "float",
        float_opts = {
          border = "rounded",
          width = function()
            return math.floor(vim.o.columns * 0.9)
          end,
          height = function()
            return math.floor(vim.o.lines * 0.9)
          end,
        },
      },

      fullscreen = {
        direction = "float",
        float_opts = {
          border = "none",
          width = function()
            return vim.o.columns
          end,
          height = function()
            return vim.o.lines
          end,
          row = 0,
          col = 0,
          winblend = 0,
        },
      },

      sidebar = {
        direction = "vertical",
        size = function()
          return math.floor(vim.o.columns * 0.4)
        end,
      },
    }

    -- =========================
    -- 🧠 STATE
    -- =========================

    local current_mode = "center"

    local function apply_ui(term)
      local mode = ui_modes[current_mode]

      term.direction = mode.direction

      if mode.direction == "float" then
        term.float_opts = mode.float_opts
      else
        term.size = mode.size
      end
    end

    -- =========================
    -- 🤖 AI Instances
    -- =========================

    local function create_ai(cmd)
      local term = Terminal:new({
        cmd = cmd,
        hidden = true,
        close_on_exit = false,
        direction = "float",
        on_open = function(term)
          vim.cmd("startinsert!")
          vim.fn.system("tmux set-window-option @claude_status '' 2>/dev/null")
        end,
      })
      apply_ui(term) -- ✅ 初始化 UI
      return term
    end

    local claude = create_ai("volta run --node 24.13.1 claude")
    local gemini = create_ai("volta run --node 24.13.1 gemini")

    local function switch_mode(mode)
      current_mode = mode

      -- 重新套用 UI（不 kill process）
      apply_ui(claude)
      apply_ui(gemini)

      -- 如果有開著，refresh UI
      if claude:is_open() then
        claude:close()
        claude:open()
      end

      if gemini:is_open() then
        gemini:close()
        gemini:open()
      end

      vim.notify("AI UI mode: " .. mode)
    end

    vim.keymap.set("n", "<leader>am", function()
      switch_mode("center")
    end, { desc = "Center Mode" })

    vim.keymap.set("n", "<leader>af", function()
      switch_mode("fullscreen")
    end, { desc = "Fullscreen Mode" })

    -- =========================
    -- 🔁 Toggle Functions
    -- =========================

    local function toggle_ai(ai)
      -- 第一次開會抓 cwd
      ai.dir = vim.loop.cwd()
      ai:toggle()
    end

    -- =========================
    -- ⌨️ Keymaps
    -- =========================

    -- Claude
    vim.keymap.set("n", "<leader>ac", function()
      toggle_ai(claude)
    end, { desc = "Toggle Claude" })

    -- Gemini
    vim.keymap.set("n", "<leader>ag", function()
      toggle_ai(gemini)
    end, { desc = "Toggle Gemini" })

    -- =========================
    -- 🎯 UX: Terminal keymaps
    -- =========================

    -- ESC 離開 terminal mode
    vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], { silent = true })

    -- 在 terminal 也能 toggle
    vim.keymap.set("t", "<leader>ac", function()
      toggle_ai(claude)
    end)

    vim.keymap.set("t", "<leader>ag", function()
      toggle_ai(gemini)
    end)

    -- =========================
    -- 🚀 Send Code to AI
    -- =========================

    local function send_to_ai(ai)
      local mode = vim.fn.mode()
      local text = ""

      if mode == "v" or mode == "V" then
        -- visual selection
        local lines = vim.fn.getline("'<", "'>")
        text = table.concat(lines, "\n")
      else
        -- current line
        text = vim.fn.getline(".")
      end

      ai:open()
      ai:send(text, true)
    end

    -- visual mode: send to Claude
    vim.keymap.set("v", "<leader>asc", function()
      send_to_ai(claude)
    end, { desc = "Send to Claude" })

    -- normal mode: send line
    vim.keymap.set("n", "<leader>asc", function()
      send_to_ai(claude)
    end)

    -- Gemini version
    vim.keymap.set("v", "<leader>asg", function()
      send_to_ai(gemini)
    end)

    vim.keymap.set("n", "<leader>asg", function()
      send_to_ai(gemini)
    end)

    -- 傳送目前檔案路徑給 Claude
    vim.keymap.set("n", "<leader>asf", function()
      local filepath = vim.fn.expand("%:p")
      claude:open()
      claude:send(filepath, true)
    end, { desc = "Send file path to Claude" })

    -- =========================
    -- 🧠 Smart UX Enhancements
    -- =========================

    -- terminal 開啟自動 insert
    vim.api.nvim_create_autocmd("TermOpen", {
      pattern = "term://*",
      callback = function()
        vim.cmd("startinsert")
      end,
    })
  end,
}
