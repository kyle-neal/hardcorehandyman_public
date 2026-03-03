defmodule Hardcorehandyman.QuotesTest do
  use Hardcorehandyman.DataCase

  alias Hardcorehandyman.Quotes

  describe "quote" do
    alias Hardcorehandyman.Quotes.Quote

    import Hardcorehandyman.QuotesFixtures

    @invalid_attrs %{
      addr: nil,
      city: nil,
      country: nil,
      description: nil,
      email: nil,
      fname: nil,
      job_title: nil,
      lname: nil,
      optin: nil,
      photo_locations: nil,
      reference: nil,
      schedule: nil,
      state: nil,
      zip: nil,
      phone: nil
    }

    @valid_attrs %{
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
    }

    @update_attrs %{
      addr: "456 Oak Avenue",
      city: "Oklahoma City",
      country: "US",
      description: "Bathroom renovation including new tile and shower installation",
      email: "updated@example.com",
      fname: "Jane",
      job_title: "Bathroom Renovation",
      lname: "Doe",
      optin: false,
      photo_locations: [],
      phone: "555-987-6543",
      reference: :online_ad,
      schedule: :two_months,
      state: "OK",
      zip: "73102"
    }

    test "list_quote/0 returns all quote" do
      quote = quote_fixture()
      assert Quotes.list_quote() == [quote]
    end

    test "get_quote!/1 returns the quote with given id" do
      quote = quote_fixture()
      assert Quotes.get_quote!(quote.id) == quote
    end

    test "create_quote/1 with valid data creates a quote" do
      assert {:ok, %Quote{} = quote} = Quotes.create_quote(@valid_attrs)
      assert quote.addr == "123 Main Street"
      assert quote.city == "Lawton"
      assert quote.country == "US"
      assert quote.description == "Need to fix the kitchen sink plumbing and replace faucet"
      assert quote.email == "customer@example.com"
      assert quote.fname == "John"
      assert quote.job_title == "Kitchen Sink Repair"
      assert quote.lname == "Smith"
      assert quote.optin == true
      assert quote.photo_locations == []
      assert quote.phone == "555-123-4567"
      assert quote.reference == :ad_on_vehicle
      assert quote.schedule == :two_weeks
      assert quote.state == "OK"
      assert quote.zip == "73501"
    end

    test "create_quote/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Quotes.create_quote(@invalid_attrs)
    end

    test "update_quote/2 with valid data updates the quote" do
      quote = quote_fixture()

      assert {:ok, %Quote{} = quote} = Quotes.update_quote(quote, @update_attrs)
      assert quote.addr == "456 Oak Avenue"
      assert quote.city == "Oklahoma City"
      assert quote.country == "US"
      assert quote.description == "Bathroom renovation including new tile and shower installation"
      assert quote.email == "updated@example.com"
      assert quote.fname == "Jane"
      assert quote.job_title == "Bathroom Renovation"
      assert quote.lname == "Doe"
      assert quote.optin == false
      assert quote.photo_locations == []
      assert quote.phone == "555-987-6543"
      assert quote.reference == :online_ad
      assert quote.schedule == :two_months
      assert quote.state == "OK"
      assert quote.zip == "73102"
    end

    test "update_quote/2 with invalid data returns error changeset" do
      quote = quote_fixture()
      assert {:error, %Ecto.Changeset{}} = Quotes.update_quote(quote, @invalid_attrs)
      assert quote == Quotes.get_quote!(quote.id)
    end

    test "delete_quote/1 deletes the quote" do
      quote = quote_fixture()
      assert {:ok, %Quote{}} = Quotes.delete_quote(quote)
      assert_raise Ecto.NoResultsError, fn -> Quotes.get_quote!(quote.id) end
    end

    test "change_quote/1 returns a quote changeset" do
      quote = quote_fixture()
      assert %Ecto.Changeset{} = Quotes.change_quote(quote)
    end
  end
end
