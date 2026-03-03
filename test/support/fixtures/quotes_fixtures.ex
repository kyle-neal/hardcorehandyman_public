defmodule Hardcorehandyman.QuotesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Hardcorehandyman.Quotes` context.
  """

  @doc """
  Generate a quote.
  """
  def quote_fixture(attrs \\ %{}) do
    {:ok, quote} =
      attrs
      |> Enum.into(%{
        addr: "123 Main Street",
        city: "Lawton",
        country: "US",
        description: "Need to fix the kitchen sink plumbing and replace faucet",
        email: "customer@example.com",
        fname: "John",
        job_title: "Kitchen Sink Repair",
        lname: "Smith",
        optin: true,
        photo_locations: [],
        phone: "555-123-4567",
        reference: :ad_on_vehicle,
        schedule: :two_weeks,
        state: "OK",
        zip: "73501"
      })
      |> Hardcorehandyman.Quotes.create_quote()

    quote
  end
end
