const DEFAULT_API_BASE = "http://127.0.0.1:8000/api";
const API_BASE =
  window.SMARTCROP_API_BASE ||
  localStorage.getItem("smartcrop_api_base") ||
  DEFAULT_API_BASE;

async function requestJson(url, options = {}) {
  const res = await fetch(url, options);
  const contentType = res.headers.get("content-type") || "";
  const isJson = contentType.includes("application/json");
  const payload = isJson ? await res.json() : null;

  if (!res.ok) {
    const error = new Error(payload?.detail || `Request failed (${res.status})`);
    error.status = res.status;
    error.payload = payload;
    throw error;
  }

  return payload;
}

// LOGIN
async function loginUser(email, password) {
  return requestJson(`${API_BASE}/auth/login`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ email, password })
  });
}

// REGISTER
async function registerUser(name, email, password) {
  return requestJson(`${API_BASE}/auth/register`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ name, email, password })
  });
}

// CROP PREDICTION
async function predictCrop(data) {
  return requestJson(`${API_BASE}/crop/predict`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(data)
  });
}

// WEATHER
async function getWeather(city) {
  const query = city ? `?city=${encodeURIComponent(city)}` : "";
  return requestJson(`${API_BASE}/weather/${query}`);
}

// DASHBOARD
async function getDashboard() {
  return requestJson(`${API_BASE}/dashboard/`);
}

function setApiBase(baseUrl) {
  localStorage.setItem("smartcrop_api_base", baseUrl);
}

window.SmartCropApi = {
  loginUser,
  registerUser,
  predictCrop,
  getWeather,
  getDashboard,
  setApiBase
};
