defmodule HardcorehandymanWeb.CustomComponents do
  use Phoenix.Component
  import Phoenix.VerifiedRoutes, warn: false

  # router and endpoint attrs have to be set so that the ~p sigil will work in our ~H blocks.  This is als why Phoenix.VerifiedRoutes is imported.

  # Make icons in netadmin_web/components/icons/ directory available as function components
  embed_templates "icons/*"

  def hh_icon(assigns)
end
