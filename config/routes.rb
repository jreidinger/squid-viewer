Mirror::Application.routes.draw do
  get "welcome/index"
  get "welcome/:id", to: "welcome", action: "get", as: "binary"
  root to: "welcome", action: "index"
end
