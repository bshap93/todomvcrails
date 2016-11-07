Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, 'c9a91478ea9ced260d73', '5db00c4e6e82d9795e290af0424dbd71f48a9352'
end
