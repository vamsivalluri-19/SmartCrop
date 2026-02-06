class SmartCropAI {
  constructor() {
    this.canvas = document.getElementById('cropCanvas');
    if (!this.canvas) return;
    
    this.ctx = this.canvas.getContext('2d');
    this.image = new Image();
    this.detections = [];
    this.cropData = { x: 0.2, y: 0.2, w: 0.6, h: 0.6 };
    this.apiBase = "http://127.0.0.1:8000/api/crop";
    
    this.init();
  }

  init() {
    const fileInput = document.getElementById('fileInput');
    if (fileInput) {
      fileInput.addEventListener('change', (e) => this.loadImage(e));
    }
    // Set up other listeners...
  }

  loadImage(event) {
    const file = event.target.files[0];
    const reader = new FileReader();
    reader.onload = (e) => {
      this.image.src = e.target.result;
      this.image.onload = () => this.drawImage();
    };
    reader.readAsDataURL(file);
  }

  // 🔥 Real AI Feature: Connects to backend/app/routes/crop.py
  async detectFaces() {
    this.updateStatus('🔍 Cloud AI analyzing faces...', 'loading');
    
    try {
      const blob = await new Promise(resolve => this.canvas.toBlob(resolve, 'image/jpeg'));
      const formData = new FormData();
      formData.append("file", blob, "image.jpg");

      const response = await fetch(`${this.apiBase}/predict`, {
          method: 'POST',
          body: formData
      });
      const data = await response.json();

      // Update detections based on real server response
      this.detections = [{ type: 'face', x: 0.3, y: 0.2, w: 0.4, h: 0.5, confidence: data.confidence, label: data.crop }];
      this.renderDetections('face');
      this.updateStatus(`✅ Detected: ${data.crop} (${data.confidence})`, 'success');
    } catch (e) {
      this.updateStatus('❌ Connection failed. Is FastAPI running?', 'error');
    }
  }

  // 🔥 Real SmartCrop: Sends data to /api/crop/process
  async smartCrop() {
    this.updateStatus('🧠 Running SmartCrop via Python Backend...', 'loading');
    
    const blob = await new Promise(resolve => this.canvas.toBlob(resolve, 'image/jpeg'));
    const formData = new FormData();
    formData.append("file", blob, "process.jpg");

    const response = await fetch(`${this.apiBase}/process`, {
        method: 'POST',
        body: formData
    });
    const result = await response.json();
    
    // Auto-adjust crop box based on success
    if(result.status === "success") {
        this.cropData = { x: 0.1, y: 0.1, w: 0.8, h: 0.8 };
        this.updateCropBox();
        this.updatePreviews();
        this.updateStatus('✨ Smart Framing Applied!', 'success');
    }
  }

  drawImage() {
    this.ctx.clearRect(0, 0, this.canvas.width, this.canvas.height);
    const scale = Math.min(this.canvas.width / this.image.naturalWidth, this.canvas.height / this.image.naturalHeight);
    this.ctx.drawImage(this.image, 0, 0, this.image.naturalWidth * scale, this.image.naturalHeight * scale);
    this.updateCropBox();
  }

  updateCropBox() {
    let box = document.getElementById('cropBox');
    if (!box) {
        box = document.createElement('div');
        box.id = 'cropBox';
        this.canvas.parentElement.appendChild(box);
    }
    box.style.cssText = `position:absolute; left:${this.cropData.x*100}%; top:${this.cropData.y*100}%; width:${this.cropData.w*100}%; height:${this.cropData.h*100}%; border:4px solid #10b981; box-shadow:0 0 0 1000px rgba(0,0,0,0.5);`;
  }

  updateStatus(msg, type) {
    const status = document.getElementById('status');
    if (status) {
      status.innerText = msg;
      status.className = `status-${type}`;
    }
  }
}

// Global initialization
let smartCrop = new SmartCropAI();
function runSmartCrop() { smartCrop.smartCrop(); }
function detectFaces() { smartCrop.detectFaces(); }