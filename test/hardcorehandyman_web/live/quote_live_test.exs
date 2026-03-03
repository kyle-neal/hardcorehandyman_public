defmodule HardcorehandymanWeb.QuoteLiveTest do
  use HardcorehandymanWeb.ConnCase

  import Phoenix.LiveViewTest

  describe "QuoteLive" do
    test "renders the quote page with form", %{conn: conn} do
      {:ok, _view, html} = live(conn, ~p"/quote")

      assert html =~ "Start a Quote"
      assert html =~ "Job Title"
      assert html =~ "Description"
      assert html =~ "Upload photos for the job"
    end

    test "shows personal information fields", %{conn: conn} do
      {:ok, _view, html} = live(conn, ~p"/quote")

      assert html =~ "Personal Information"
      assert html =~ "First name"
      assert html =~ "Last name"
      assert html =~ "Email address"
      assert html =~ "Phone Number"
      assert html =~ "Street address"
      assert html =~ "City"
      assert html =~ "State / Province"
      assert html =~ "ZIP / Postal code"
    end

    test "shows schedule options", %{conn: conn} do
      {:ok, _view, html} = live(conn, ~p"/quote")

      assert html =~ "When would you like this job done?"
      assert html =~ "Within the next two weeks"
      assert html =~ "Within the next two months"
      assert html =~ "No timeline"
    end

    test "shows reference options", %{conn: conn} do
      {:ok, _view, html} = live(conn, ~p"/quote")

      assert html =~ "How did you hear about me?"
      assert html =~ "Google Search"
      assert html =~ "Saw ad on my vehicle"
      assert html =~ "Online Advertisement"
      assert html =~ "Yelp"
      assert html =~ "Facebook"
      assert html =~ "Word of mouth"
    end

    test "shows newsletter opt-in checkbox", %{conn: conn} do
      {:ok, _view, html} = live(conn, ~p"/quote")

      assert html =~ "Subscribe to my newsletter?"
    end

    test "shows submit button", %{conn: conn} do
      {:ok, _view, html} = live(conn, ~p"/quote")

      assert html =~ "Submit Quote"
    end

    test "validates form on change", %{conn: conn} do
      {:ok, view, _html} = live(conn, ~p"/quote")

      html =
        view
        |> element("#quote-form")
        |> render_change(%{
          "quote" => %{
            "job_title" => "Fix",
            "description" => "short",
            "fname" => "J",
            "lname" => "S",
            "email" => "invalid",
            "phone" => "123",
            "addr" => "1",
            "city" => "L",
            "state" => "OKL",
            "zip" => "1"
          }
        })

      # Should show validation errors
      assert html =~ "at least"
    end

    test "validates form accepts valid data", %{conn: conn} do
      {:ok, view, _html} = live(conn, ~p"/quote")

      html =
        view
        |> element("#quote-form")
        |> render_change(%{
          "quote" => %{
            "job_title" => "Kitchen Sink Repair",
            "description" => "Need to fix the kitchen sink plumbing and replace faucet",
            "fname" => "John",
            "lname" => "Smith",
            "email" => "customer@example.com",
            "phone" => "555-123-4567",
            "addr" => "123 Main Street",
            "city" => "Lawton",
            "state" => "OK",
            "zip" => "73501",
            "schedule" => "two_weeks",
            "reference" => "ad_on_vehicle",
            "optin" => "true"
          }
        })

      # Valid data should not show main validation errors
      refute html =~ "can&#39;t be blank"
    end

    test "shows upload area for photos", %{conn: conn} do
      {:ok, _view, html} = live(conn, ~p"/quote")

      assert html =~ "Upload a file"
      assert html =~ "or drag and drop here"
      assert html =~ "photos max"
    end
  end
end
