# Set working directory to your Git repository
setwd('/Users/jacobpollard/Desktop/Uni/1.2/BABS-2 /Tutor/Week 6 figure for report/Week 6 figure Tonon et al.')  # Change this to your actual path

# Run Git commands
system("git add .")
system('git commit -m "Auto commit $(date)"')  # Adds a timestamp to commit message
system("git push origin main")  # Change "main" to your branch name if needed
