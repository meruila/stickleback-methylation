from tkinter import *
from tkinter import ttk
from tkinter import filedialog
from tkinter.messagebox import showinfo
window = Tk()
window.title("Methylation Analysis")
window.geometry('960x620')

def click_me():
    flag = 0
    if qc.get() == 0 and methyl.get() == 0 and sra.get() == 0:
        print("Required to choose a tool.")
        flag = 1
    if flag == 0:
        for widget in window.winfo_children():
            widget.destroy()
        options = "SRA " + str(sra.get()) + " QC " + str(qc.get()) + " Methyl " + str(methyl.get())
        print(options)
        get_input(sra.get(), qc.get(), methyl.get())

def reset():
    sra.set(None)
    qc.set(None)
    methyl.set(None)

def open_sra_file():
    filetype = [('text files', '*.txt')]
    filename = filedialog.askopenfilename(title='Open plaintext file with SRA download links', initialdir='.', filetypes=filetype)
    sra_label = Label(window, text=filename, font=('Helvetica', 12))
    sra_label.grid(row=4, column=2, padx=10, pady=5, sticky='w')

def open_dl_directory():
    dirname = filedialog.askdirectory(title='Open directory on where the downloads will be placed', initialdir='.', mustexist=True)
    sra_label = Label(window, text=dirname, font=('Helvetica', 12))
    sra_label.grid(row=7, column=2, padx=10, pady=5, sticky='w')

def get_input(sra_in, qc_in, meth_in):
    if sra_in == 1:
        preprocess = Label(window, text="Retrieval of reads:", font=('Helvetica', 14))
        preprocess.grid(row=1, column=1, padx=10, pady=5, sticky='w')
        r_text = Label(window, text="Open text file containing", font=('Helvetica', 13))
        r_text.grid(row=2, column=1, padx=10, pady=2, sticky='w')
        r2_text = Label(window, text="SRA download links", font=('Helvetica', 13))
        r2_text.grid(row=3, column=1, padx=10, pady=2, sticky='w')
        reads = Button(window,text="Open File", font=('Helvetica', 13), command=open_sra_file)
        reads.grid(row=4, column=1, padx=10, pady=5, sticky='w')

        r_text = Label(window, text="Open directory on where", font=('Helvetica', 13))
        r_text.grid(row=5, column=1, padx=10, pady=2, sticky='w')
        r2_text = Label(window, text="the downloads will be placed", font=('Helvetica', 13))
        r2_text.grid(row=6, column=1, padx=10, pady=2, sticky='w')
        reads = Button(window,text="Open Directory", font=('Helvetica', 13), command=open_dl_directory)
        reads.grid(row=7, column=1, padx=10, pady=5, sticky='w')
    if qc_in == 1:
        pass
    elif qc_in == 2:
        pass
    if meth_in == 1:
        pass
    elif meth_in == 2:
        pass


instruct = Label(window, text="To analyze methylation patterns in stickleback reads, pick the tools to be used in the workflow.", font=('Helvetica', 14))
instruct.grid(row=0, column=1, padx=10, pady=10)

# Reads retrieval
preprocess = Label(window, text="Retrieval of reads:", font=('Helvetica', 14))
preprocess.grid(row=1, column=1, padx=10, pady=5, sticky='w')

sra = IntVar()
c = Checkbutton(window, text = "SRA Reads Downloader", font=('Helvetica', 13), variable=sra)
c.grid(row=2, column=1, padx=10, pady=5, sticky='w')

# Quality control
qc = IntVar()
qc_label = Label(window, text="Quality control:", font=('Helvetica', 14))
qc_label.grid(row=3, column=1, padx=10, pady=5, sticky='w')

r1 = Radiobutton(window, text="Fastp", font=('Helvetica', 13), variable=qc, value=1)
r1.grid(row=4, column=1, padx=10, pady=2.5, sticky='w')
r2 = Radiobutton(window, text="FastQC", font=('Helvetica', 13), variable=qc, value=2)
r2.grid(row=5, column=1, padx=10, pady=2.5, sticky='w')

# Methylation analysis
methyl = IntVar()
m_label = Label(window, text="Methylation analysis:", font=('Helvetica', 14))
m_label.grid(row=6, column=1, padx=10, pady=5, sticky='w')

r3 = Radiobutton(window, text="BiSulfiteBolt", font=('Helvetica', 13), variable=methyl, value=1)
r3.grid(row=7, column=1, padx=10, pady=2.5, sticky='w')
r4 = Radiobutton(window, text="Bismark", font=('Helvetica', 13), variable=methyl, value=2)
r4.grid(row=8, column=1, padx=10, pady=2.5, sticky='w')

b = Button(window,text="Confirm", font=('Helvetica', 13), command=click_me)
b.grid(row=9, column=1, padx=10, pady=5, sticky='w')

r = Button(window,text="Reset", font=('Helvetica', 13), command=reset)
r.grid(row=10, column=1, padx=10, pady=5, sticky='w')

window.mainloop()

