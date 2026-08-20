#!/usr/bin/env python3
import i3ipc

def on_window_new(sway, event):
    # Get the currently focused workspace
    focused_workspace = sway.get_tree().find_focused().workspace()
    
    # Count how many windows (leaves) are in this workspace
    # We subtract 1 because the newly opened window is already counted
    window_count = len(focused_workspace.leaves())
    
    # If there were already 2 windows (making it 3 now), move the new one
    if window_count > 2:
        # Find the next available workspace number
        workspaces = [w.num for w in sway.get_workspaces()]
        next_num = 1
        while next_num in workspaces:
            next_num += 1
            
        # Move the container to the new workspace and switch to it
        event.container.command(f"move container to workspace {next_num}")
        sway.command(f"workspace {next_num}")

def main():
    # Connect to the Sway IPC socket
    sway = i3ipc.Connection()
    
    # Listen specifically for when a new window is opened
    sway.on(i3ipc.Event.WINDOW_NEW, on_window_new)
    
    # Keep the script running in the background
    sway.main()

if __name__ == "__main__":
    main()
