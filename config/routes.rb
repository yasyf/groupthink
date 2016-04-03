Rails.application.routes.draw do
  get 'list/:username/:name' => 'list#view'
end
