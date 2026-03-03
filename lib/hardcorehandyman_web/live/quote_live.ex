defmodule HardcorehandymanWeb.QuoteLive do
  use HardcorehandymanWeb, :live_view
  alias HardcorehandymanWeb.QuoteFormComponent
  alias Hardcorehandyman.Mailer

  ### ===================================================================
  ### Mount
  ### ===================================================================

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  ### ===================================================================
  ### Handle Events
  ### ===================================================================

  def handle_event(event, p, socket) do
    IO.inspect(event)
    IO.inspect(p)
    {:noreply, socket}
  end

  def handle_info({:error, _changeset}, socket) do
    socket =
      socket
      |> put_flash(:error, "Please correct the errors")

    {:noreply, socket}
  end

  def handle_info({:created, quote}, socket) do
    IO.inspect(quote, label: "quote (in quote_live)")

    case Mailer.send_quote(quote) do
      {:ok, email} ->
        IO.inspect(email, label: "email (in quote_live)")

        socket =
          socket
          |> put_flash(:info, "Quote submitted successfully")
          |> push_navigate(to: ~p"/")

        {:noreply, socket}

      {:error, reason} ->
        IO.inspect(reason, label: "reason (in quote_live)")

        socket =
          socket
          |> put_flash(
            :error,
            "Quote could not be submitted, please contact us directly if this persists"
          )

        {:noreply, socket}
    end
  end

  ### ===================================================================
  ### Render
  ### ===================================================================

  def render(assigns) do
    ~H"""
    <div class="pt-32 bg-white">
      <.live_component module={QuoteFormComponent} id={:new} />
    </div>
    """
  end

  ### ===================================================================
  ### Components
  ### ===================================================================
end
