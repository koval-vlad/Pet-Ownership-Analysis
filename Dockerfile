# Use a lightweight Python base
FROM python:3.11-slim

# 1. Stay as root for all installations and setup
USER root

# 2. Set working directory
WORKDIR /code

# 3. Install system dependencies, emoji fonts, and fallback symbol fonts
RUN apt-get update && apt-get install -y \
    build-essential \
    libfreetype6-dev \
    libpng-dev \
    fontconfig \
    fonts-noto-color-emoji \
    fonts-symbola \
    fonts-freefont-ttf \
    && rm -rf /var/lib/apt/lists/* \
    && fc-cache -f -v

# 4. Create the 'user' that Hugging Face expects (UID 1000)
RUN useradd -m -u 1000 user

# 5. Copy requirements and install them as root (to ensure permissions)
# or switch to user now. Let's install as root for stability.
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# 6. Copy the rest of the app
COPY . .

# 7. Set permissions so 'user' can access /code
RUN chown -R user:user /code && chmod -R 777 /code

# 8. Switch to the non-root user for security and HF compatibility
USER user
# Ensure the user's local bin is in PATH for 'panel' command
ENV PATH="/home/user/.local/bin:${PATH}"

# Command to serve the Jupyter Notebook as a Panel app
CMD ["panel", "serve", "pet_ownership_analysis.ipynb", \
     "--address", "0.0.0.0", \
     "--port", "7860", \
     "--allow-websocket-origin", "*"]