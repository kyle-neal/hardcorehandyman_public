defmodule Hardcorehandyman.Quotes.QuoteTest do
  use Hardcorehandyman.DataCase

  alias Hardcorehandyman.Quotes.Quote

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

  describe "changeset/2" do
    test "valid attrs produce a valid changeset" do
      changeset = Quote.changeset(%Quote{}, @valid_attrs)
      assert changeset.valid?
    end

    test "requires job_title" do
      attrs = Map.delete(@valid_attrs, :job_title)
      changeset = Quote.changeset(%Quote{}, attrs)
      assert %{job_title: ["can't be blank"]} = errors_on(changeset)
    end

    test "requires description" do
      attrs = Map.delete(@valid_attrs, :description)
      changeset = Quote.changeset(%Quote{}, attrs)
      assert %{description: ["can't be blank"]} = errors_on(changeset)
    end

    test "requires fname" do
      attrs = Map.delete(@valid_attrs, :fname)
      changeset = Quote.changeset(%Quote{}, attrs)
      assert %{fname: ["can't be blank"]} = errors_on(changeset)
    end

    test "requires lname" do
      attrs = Map.delete(@valid_attrs, :lname)
      changeset = Quote.changeset(%Quote{}, attrs)
      assert %{lname: ["can't be blank"]} = errors_on(changeset)
    end

    test "requires email" do
      attrs = Map.delete(@valid_attrs, :email)
      changeset = Quote.changeset(%Quote{}, attrs)
      assert %{email: ["can't be blank"]} = errors_on(changeset)
    end

    test "requires addr" do
      attrs = Map.delete(@valid_attrs, :addr)
      changeset = Quote.changeset(%Quote{}, attrs)
      assert %{addr: ["can't be blank"]} = errors_on(changeset)
    end

    test "requires city" do
      attrs = Map.delete(@valid_attrs, :city)
      changeset = Quote.changeset(%Quote{}, attrs)
      assert %{city: ["can't be blank"]} = errors_on(changeset)
    end

    test "requires state" do
      attrs = Map.delete(@valid_attrs, :state)
      changeset = Quote.changeset(%Quote{}, attrs)
      assert %{state: ["can't be blank"]} = errors_on(changeset)
    end

    test "requires zip" do
      attrs = Map.delete(@valid_attrs, :zip)
      changeset = Quote.changeset(%Quote{}, attrs)
      assert %{zip: ["can't be blank"]} = errors_on(changeset)
    end

    test "requires phone" do
      attrs = Map.delete(@valid_attrs, :phone)
      changeset = Quote.changeset(%Quote{}, attrs)
      assert %{phone: ["can't be blank"]} = errors_on(changeset)
    end

    test "requires schedule" do
      attrs = Map.delete(@valid_attrs, :schedule)
      changeset = Quote.changeset(%Quote{}, attrs)
      assert %{schedule: ["can't be blank"]} = errors_on(changeset)
    end

    test "requires reference" do
      attrs = Map.delete(@valid_attrs, :reference)
      changeset = Quote.changeset(%Quote{}, attrs)
      assert %{reference: ["can't be blank"]} = errors_on(changeset)
    end

    test "optin defaults to true in schema" do
      quote = %Quote{}
      assert quote.optin == true
    end

    test "validates email format requires @" do
      attrs = Map.put(@valid_attrs, :email, "invalidemail")
      changeset = Quote.changeset(%Quote{}, attrs)
      refute changeset.valid?
    end

    test "validates email has TLD after @" do
      attrs = Map.put(@valid_attrs, :email, "user@localhost")
      changeset = Quote.changeset(%Quote{}, attrs)
      refute changeset.valid?
    end

    test "accepts valid email with TLD" do
      attrs = Map.put(@valid_attrs, :email, "user@domain.com")
      changeset = Quote.changeset(%Quote{}, attrs)
      assert changeset.valid?
    end

    test "validates description minimum length (10)" do
      attrs = Map.put(@valid_attrs, :description, "short")
      changeset = Quote.changeset(%Quote{}, attrs)
      assert %{description: [msg]} = errors_on(changeset)
      assert msg =~ "at least"
    end

    test "validates description maximum length (500)" do
      attrs = Map.put(@valid_attrs, :description, String.duplicate("a", 501))
      changeset = Quote.changeset(%Quote{}, attrs)
      assert %{description: [msg]} = errors_on(changeset)
      assert msg =~ "most"
    end

    test "validates job_title minimum length (5)" do
      attrs = Map.put(@valid_attrs, :job_title, "Fix")
      changeset = Quote.changeset(%Quote{}, attrs)
      assert %{job_title: [msg]} = errors_on(changeset)
      assert msg =~ "at least"
    end

    test "validates job_title maximum length (50)" do
      attrs = Map.put(@valid_attrs, :job_title, String.duplicate("a", 51))
      changeset = Quote.changeset(%Quote{}, attrs)
      assert %{job_title: [msg]} = errors_on(changeset)
      assert msg =~ "most"
    end

    test "validates fname minimum length (2)" do
      attrs = Map.put(@valid_attrs, :fname, "J")
      changeset = Quote.changeset(%Quote{}, attrs)
      assert %{fname: [_msg]} = errors_on(changeset)
    end

    test "validates lname minimum length (2)" do
      attrs = Map.put(@valid_attrs, :lname, "S")
      changeset = Quote.changeset(%Quote{}, attrs)
      assert %{lname: [_msg]} = errors_on(changeset)
    end

    test "validates addr minimum length (5)" do
      attrs = Map.put(@valid_attrs, :addr, "123")
      changeset = Quote.changeset(%Quote{}, attrs)
      assert %{addr: [_msg]} = errors_on(changeset)
    end

    test "validates city minimum length (2)" do
      attrs = Map.put(@valid_attrs, :city, "L")
      changeset = Quote.changeset(%Quote{}, attrs)
      assert %{city: [_msg]} = errors_on(changeset)
    end

    test "validates state is exactly 2 characters" do
      attrs = Map.put(@valid_attrs, :state, "OKL")
      changeset = Quote.changeset(%Quote{}, attrs)
      assert %{state: [_msg]} = errors_on(changeset)
    end

    test "validates zip minimum length (5)" do
      attrs = Map.put(@valid_attrs, :zip, "123")
      changeset = Quote.changeset(%Quote{}, attrs)
      assert %{zip: [_msg]} = errors_on(changeset)
    end

    test "validates phone minimum length (10)" do
      attrs = Map.put(@valid_attrs, :phone, "555-1234")
      changeset = Quote.changeset(%Quote{}, attrs)
      refute changeset.valid?
    end

    test "validates phone format" do
      attrs = Map.put(@valid_attrs, :phone, "not-a-phone-number-at-all")
      changeset = Quote.changeset(%Quote{}, attrs)
      refute changeset.valid?
    end

    test "accepts valid US phone formats" do
      valid_phones = [
        "555-123-4567",
        "(555) 123-4567",
        "5551234567",
        "+1 555-123-4567"
      ]

      for phone <- valid_phones do
        attrs = Map.put(@valid_attrs, :phone, phone)
        changeset = Quote.changeset(%Quote{}, attrs)
        assert changeset.valid?, "Expected phone #{phone} to be valid"
      end
    end

    test "validates schedule enum values" do
      for schedule <- [:two_weeks, :two_months, :no_timeline] do
        attrs = Map.put(@valid_attrs, :schedule, schedule)
        changeset = Quote.changeset(%Quote{}, attrs)
        assert changeset.valid?, "Expected schedule #{schedule} to be valid"
      end
    end

    test "validates reference enum values" do
      for reference <- [:ad_on_vehicle, :online_ad, :google_search, :yelp, :facebook, :word_of_mouth] do
        attrs = Map.put(@valid_attrs, :reference, reference)
        changeset = Quote.changeset(%Quote{}, attrs)
        assert changeset.valid?, "Expected reference #{reference} to be valid"
      end
    end

    test "defaults country to US" do
      attrs = Map.delete(@valid_attrs, :country)
      changeset = Quote.changeset(%Quote{}, attrs)
      assert changeset.valid?
    end

    test "defaults optin to true" do
      quote = %Quote{}
      assert quote.optin == true
    end

    test "accepts photo_locations as array of strings" do
      attrs = Map.put(@valid_attrs, :photo_locations, ["/tmp/photo1.jpg", "/tmp/photo2.jpg"])
      changeset = Quote.changeset(%Quote{}, attrs)
      assert changeset.valid?
    end
  end
end
