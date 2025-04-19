---@meta
-- luacheck: no unused args
error('Cannot require a meta file')

--- Signal handles implement Unix style signal handling on a per-event loop bases.
---
--- **Unix Notes:**
---
--- - SIGKILL and SIGSTOP are impossible to catch.
---
--- - Handling SIGBUS, SIGFPE, SIGILL or SIGSEGV via libuv results into undefined behavior.
---
--- - SIGABRT will not be caught by libuv if generated by abort(), e.g. through assert().
---
--- - On Linux SIGRT0 and SIGRT1 (signals 32 and 33) are used by the NPTL pthreads library to manage threads. Installing watchers for those signals will lead to unpredictable behavior and is strongly discouraged. Future versions of libuv may simply reject them.
---
--- **Windows Notes:**
---
--- Reception of some signals is emulated on Windows:
--- - SIGINT is normally delivered when the user presses CTRL+C. However, like on Unix, it is not generated when terminal raw mode is enabled.
---
--- - SIGBREAK is delivered when the user pressed CTRL + BREAK.
---
--- - SIGHUP is generated when the user closes the console window. On SIGHUP the program is given approximately 10 seconds to perform cleanup. After that Windows will unconditionally terminate it.
---
--- - SIGWINCH is raised whenever libuv detects that the console has been resized. SIGWINCH is emulated by libuv when the program uses a uv_tty_t handle to write to the console. SIGWINCH may not always be delivered in a timely manner; libuv will only detect size changes when the cursor is being moved. When a readable `uv_tty_t` handle is used in raw mode, resizing the console buffer will also trigger a SIGWINCH signal.
---
--- - Watchers for other signals can be successfully created, but these signals are never received. These signals are: SIGILL, SIGABRT, SIGFPE, SIGSEGV, SIGTERM and SIGKILL.
---
--- - Calls to raise() or abort() to programmatically raise a signal are not detected by libuv; these will not trigger a signal watcher.
---
---
--- ```lua
--- -- Create a new signal handler
--- local signal = uv.new_signal()
--- -- Define a handler function
--- uv.signal_start(signal, "sigint", function(signal)
---   print("got " .. signal .. ", shutting down")
---   os.exit(1)
--- end)
--- ```
---
---@class uv.uv_signal_t : uv.uv_handle_t
---
local signal = {} -- luacheck: no unused

--- Start the handle with the given callback, watching for the given signal.
---
---@param  signum     integer|string
---@param  callback   uv.signal_start.callback
---@return 0|nil      success
---@return uv.error.message|nil err
---@return uv.error.name|nil err_name
function signal:start(signum, callback) end

--- Same functionality as `signal:start()` but the signal handler is reset the moment the signal is received.
---
---@param  signum     integer|string
---@param  callback   uv.signal_start_oneshot.callback
---@return 0|nil      success
---@return uv.error.message|nil err
---@return uv.error.name|nil err_name
function signal:start_oneshot(signum, callback) end

--- Stop the handle, the callback will no longer be called.
---
---@return 0|nil      success
---@return uv.error.message|nil err
---@return uv.error.name|nil err_name
function signal:stop() end
