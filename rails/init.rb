require 'blacklight_mlt'

# We do our injection in after_initialize so an app can stop it or configure
# it in an initializer, using BlacklightOaiProvider.omit_inject .
# Only weirdness about this is our CSS will always be last, so if an app
# wants to over-ride it, might want to set BlacklightOaiProvider.omit_inject => {:css => true}
config.to_prepare do
  BlacklightMlt.inject!
end
