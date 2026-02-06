// API Configuration for SmartCrop
const API_CONFIG = {
  // Backend API URL - Update this after deploying backend
  API_URL: window.location.hostname === 'localhost' || window.location.hostname === '127.0.0.1'
    ? 'http://localhost:8000'  // Local development
    : 'https://smartcrop-backend.onrender.com',  // Production - Update after deployment
  
  // Demo mode - set to true to work without backend
  DEMO_MODE: true,
  
  // API Endpoints
  endpoints: {
    // Auth
    LOGIN: '/api/auth/login',
    REGISTER: '/api/auth/register',
    PROFILE: '/api/auth/profile',
    
    // Crop
    CROP_IMAGE: '/api/crop/image',
    CROP_VIDEO: '/api/crop/video',
    BATCH_CROP: '/api/crop/batch',
    
    // Dashboard
    DASHBOARD: '/api/dashboard',
    STATS: '/api/dashboard/stats',
    RECENT: '/api/dashboard/recent',
    
    // Weather
    WEATHER: '/api/weather',
    ADVISORY: '/api/weather/advisory',
  }
};

// API Helper Functions
const API = {
  // Get full URL for an endpoint
  getUrl(endpoint) {
    return API_CONFIG.API_URL + endpoint;
  },
  
  // Make API request with authentication
  async request(endpoint, options = {}) {
    const token = localStorage.getItem('smartcrop_token');
    const headers = {
      'Content-Type': 'application/json',
      ...options.headers,
    };
    
    if (token && token !== 'demo_token_' + Date.now()) {
      headers['Authorization'] = `Bearer ${token}`;
    }
    
    // If in demo mode, return mock data
    if (API_CONFIG.DEMO_MODE) {
      console.log('DEMO MODE: Simulating API call to', endpoint);
      return this.getMockResponse(endpoint);
    }
    
    try {
      const response = await fetch(this.getUrl(endpoint), {
        ...options,
        headers,
      });
      
      if (!response.ok) {
        throw new Error(`API Error: ${response.status}`);
      }
      
      return await response.json();
    } catch (error) {
      console.error('API Request failed:', error);
      throw error;
    }
  },
  
  // Mock responses for demo mode
  getMockResponse(endpoint) {
    return new Promise((resolve) => {
      setTimeout(() => {
        // Mock data based on endpoint
        if (endpoint.includes('login') || endpoint.includes('register')) {
          resolve({
            success: true,
            token: 'demo_token_' + Date.now(),
            user: {
              id: 1,
              email: 'demo@smartcrop.com',
              name: 'Demo User'
            }
          });
        } else if (endpoint.includes('dashboard')) {
          resolve({
            stats: {
              totalCrops: 42,
              imagesCropped: 35,
              videosCropped: 7,
              savedTime: '3.5 hours'
            },
            recentActivity: []
          });
        } else {
          resolve({ success: true, data: {} });
        }
      }, 500); // Simulate network delay
    });
  }
};

// Export for use in other files
if (typeof module !== 'undefined' && module.exports) {
  module.exports = { API_CONFIG, API };
}
