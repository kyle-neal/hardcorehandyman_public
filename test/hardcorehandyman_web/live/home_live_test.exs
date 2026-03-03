defmodule HardcorehandymanWeb.HomeLiveTest do
  use HardcorehandymanWeb.ConnCase

  import Phoenix.LiveViewTest

  describe "HomeLive" do
    test "renders the home page", %{conn: conn} do
      {:ok, _view, html} = live(conn, ~p"/")

      assert html =~ "Need work done around the house?"
      assert html =~ "Get a free virtual quote!"
      assert html =~ "Past Jobs"
      assert html =~ "What do I do?"
      assert html =~ "Who I am"
    end

    test "displays the intro section", %{conn: conn} do
      {:ok, _view, html} = live(conn, ~p"/")

      assert html =~ "7 years of experience in contracting"
      assert html =~ "Communication is my top priority"
      assert html =~ "Start a Virtual Quote"
    end

    test "displays the virtual quote section", %{conn: conn} do
      {:ok, _view, html} = live(conn, ~p"/")

      assert html =~ "Fill the form"
      assert html =~ "Submit pictures"
      assert html =~ "Get your estimate!"
      assert html =~ "Start A Virtual Quote"
    end

    test "displays the services section", %{conn: conn} do
      {:ok, _view, html} = live(conn, ~p"/")

      # Services offered
      assert html =~ "Kitchen"
      assert html =~ "Bathroom"
      assert html =~ "Appliance Installation"
      assert html =~ "Custom Shower Installation"
      assert html =~ "Fence Installation/Repair"

      # Services NOT offered
      assert html =~ "What I don&#39;t do"
      assert html =~ "In-wall plumbing/electrical"
      assert html =~ "Gas appliances"
    end

    test "displays the who I am section", %{conn: conn} do
      {:ok, _view, html} = live(conn, ~p"/")

      assert html =~ "Taylor Baxter"
      assert html =~ "Owner and Operator"
      assert html =~ "devoted husband, firefighter"
    end

    test "displays the revenue link section", %{conn: conn} do
      {:ok, _view, html} = live(conn, ~p"/")

      assert html =~ "Need a website, or app for your business?"
      assert html =~ "RevenueLink Technologies"
      assert html =~ "https://revenuelink.net"
    end

    test "has correct page title", %{conn: conn} do
      {:ok, _view, html} = live(conn, ~p"/")

      assert html =~ "Hardcore Handyman of Lawton"
    end

    test "displays past jobs section with images", %{conn: conn} do
      {:ok, _view, html} = live(conn, ~p"/")

      assert html =~ "See why my customers are happy"
      assert html =~ "pastjobs1.png"
      assert html =~ "pastjobs2.png"
      assert html =~ "pastjobs3.png"
      assert html =~ "pastjobs4.png"
    end

    test "has navigation link to quote page", %{conn: conn} do
      {:ok, _view, html} = live(conn, ~p"/")

      assert html =~ ~s(href="/quote")
    end
  end
end
