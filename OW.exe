import customtkinter as ctk
import time
import threading
import requests
from tkinter import messagebox

# Configuration
ctk.set_appearance_mode("dark")
ctk.set_default_color_theme("blue")

# API URL
API_URL = "https://star-site-psi.vercel.app/api/pins"

class TermsPopup(ctk.CTkToplevel):
    def __init__(self, parent, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.parent = parent
        self.title("Terms & Services")
        self.geometry("520x620")
        self.configure(fg_color="#0b0e14")
        self.attributes("-topmost", True)
        self.resizable(False, False)

        ctk.CTkLabel(
            self, 
            text="Terms & Services", 
            font=("Inter", 32, "bold"), 
            text_color="white"
        ).pack(pady=(30, 20))

        self.text_frame = ctk.CTkTextbox(
            self, 
            width=460, 
            height=300, 
            fg_color="#161b22", 
            text_color="#cfd8dc",
            font=("Inter", 14), 
            corner_radius=10, 
            border_spacing=15
        )
        self.text_frame.pack(padx=20, pady=5)
        
        terms_content = (
            "• The creator of this software is not responsible for how information "
            "obtained through this tool is used by third-party leagues and members.\n\n"
            "• This tool is designed to assist in the screensharing process. No "
            "information will be distributed by the software owner.\n\n"
            "• If a league or individual using this software on you is not authorized or "
            "listed, please report it immediately by:\n"
            "  - Messaging Discord user: 6b75736872\n"
            "  - Joining the Trinity Discord server and creating a support ticket\n\n"
            "• Unauthorized usage will result in immediate revocation of access.\n\n"
            "Thank you for helping keep the community safe and fair."
        )

        self.text_frame.insert("0.0", terms_content)
        self.text_frame.configure(state="disabled") 

        self.check_var = ctk.StringVar(value="off")
        self.checkbox = ctk.CTkCheckBox(
            self, 
            text="I have read and agree to the Terms & Services",
            variable=self.check_var, 
            onvalue="on", 
            offvalue="off",
            font=("Inter", 13), 
            fg_color="#1eb673", 
            hover_color="#18915c",
            command=self.toggle_button
        )
        self.checkbox.pack(pady=20)

        self.accept_btn = ctk.CTkButton(
            self, 
            text="ACCEPT & CONTINUE", 
            fg_color="#212934", 
            text_color="#5a6675",
            state="disabled", 
            height=55, 
            width=460, 
            corner_radius=8,
            font=("Inter", 14, "bold"), 
            command=self.handle_accept
        )
        self.accept_btn.pack(pady=(0, 20))

    def toggle_button(self):
        if self.check_var.get() == "on":
            self.accept_btn.configure(
                state="normal", 
                fg_color="#1eb673", 
                text_color="white"
            )
        else:
            self.accept_btn.configure(
                state="disabled", 
                fg_color="#212934", 
                text_color="#5a6675"
            )

    def handle_accept(self):
        self.parent.show_pin_screen()
        self.destroy()


class TrinityApp(ctk.CTk):
    def __init__(self):
        super().__init__()
        self.title("Trinity — Advanced Automated Screenshare")
        self.geometry("500x550")
        self.configure(fg_color="#0b0e14")

        self.main_container = ctk.CTkFrame(self, fg_color="transparent")
        self.main_container.pack(expand=True, fill="both")

        self.show_main_menu()

    def clear_screen(self):
        for widget in self.main_container.winfo_children():
            widget.destroy()

    def show_main_menu(self):
        self.clear_screen()

        ctk.CTkLabel(
            self.main_container, 
            text="TRINITY", 
            font=("Inter", 64, "bold"), 
            text_color="white"
        ).pack(pady=(120, 5))

        ctk.CTkLabel(
            self.main_container, 
            text="Advanced Automated Screenshare", 
            font=("Inter", 16), 
            text_color="#4a6a8a"
        ).pack(pady=(0, 60))
        
        ctk.CTkButton(
            self.main_container, 
            text="GET STARTED", 
            fg_color="#1eb673", 
            height=55, 
            width=300, 
            corner_radius=8, 
            command=lambda: TermsPopup(self)
        ).pack(pady=10)

        ctk.CTkButton(
            self.main_container, 
            text="JOIN DISCORD", 
            fg_color="#5865f2", 
            height=55, 
            width=300, 
            corner_radius=8
        ).pack(pady=10)

    def show_pin_screen(self):
        self.clear_screen()

        ctk.CTkLabel(
            self.main_container, 
            text="Enter Verification PIN", 
            font=("Inter", 32, "bold"), 
            text_color="white"
        ).pack(pady=(120, 5))

        ctk.CTkLabel(
            self.main_container, 
            text="Enter the PIN provided by your checker", 
            font=("Inter", 14), 
            text_color="#4a6a8a"
        ).pack(pady=(0, 40))

        self.pin_entry = ctk.CTkEntry(
            self.main_container, 
            placeholder_text="XXXX-XXXX-XXXX", 
            width=320, 
            height=60, 
            fg_color="#1c232e", 
            border_color="#2d3748", 
            justify="center"
        )
        self.pin_entry.pack(pady=10)

        ctk.CTkButton(
            self.main_container, 
            text="START SCAN", 
            fg_color="#1eb673", 
            height=55, 
            width=320, 
            corner_radius=8,
            command=self.validate_pin
        ).pack(pady=20)

    def validate_pin(self):
        pin = self.pin_entry.get().strip()

        if not pin:
            self.pin_entry.configure(border_color="red")
            return

        try:
            res = requests.get(API_URL, timeout=10)
            data = res.json()
            pins = data.get("pins", [])

            for p in pins:
                if p["pin"] == pin:
                    self.pin_entry.configure(border_color="#1eb673")
                    self.show_scanning_screen()
                    return

            self.pin_entry.configure(border_color="red")
        except Exception:
            self.pin_entry.configure(border_color="red")

    def show_scanning_screen(self):
        self.clear_screen()

        ctk.CTkLabel(
            self.main_container, 
            text="Scanning System", 
            font=("Inter", 32, "bold"), 
            text_color="white"
        ).pack(pady=(150, 5))

        ctk.CTkLabel(
            self.main_container, 
            text="Verifying system integrity", 
            font=("Inter", 14), 
            text_color="#4a6a8a"
        ).pack(pady=(0, 40))

        self.progress_bar = ctk.CTkProgressBar(
            self.main_container, 
            width=400, 
            height=12, 
            fg_color="#1c232e", 
            progress_color="#1eb673"
        )
        self.progress_bar.set(0)
        self.progress_bar.pack(pady=10)

        self.percent_label = ctk.CTkLabel(
            self.main_container, 
            text="0%", 
            font=("Inter", 14, "bold"), 
            text_color="#1eb673"
        )
        self.percent_label.pack()

        threading.Thread(
            target=self.run_scan_simulation, 
            daemon=True
        ).start()

    def run_scan_simulation(self):
        for i in range(101):
            time.sleep(0.05)
            # Update UI from thread
            self.after(0, self.update_progress, i)
        
        # Show the OK popup when done
        self.after(0, self.show_completion_message)

    def update_progress(self, val):
        self.progress_bar.set(val / 100)
        self.percent_label.configure(text=f"{val}%")

    def show_completion_message(self):
        messagebox.showinfo(
            "Scan Complete", 
            "Scan completed successfully!\n\nResults transmitted to checker. You may close this window."
        )
        self.show_main_menu()

if __name__ == "__main__":
    app = TrinityApp()
    app.mainloop()