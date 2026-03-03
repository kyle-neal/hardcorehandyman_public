defmodule HardcorehandymanWeb.CoreComponentsTest do
  use ExUnit.Case, async: true

  use Phoenix.Component
  import Phoenix.LiveViewTest
  import HardcorehandymanWeb.CoreComponents

  defp do_render(func) do
    assigns = %{}
    rendered_to_string(func.(assigns))
  end

  describe "button/1" do
    test "renders a button with inner content" do
      html = do_render(fn assigns ->
        ~H"""
        <.button>Click me</.button>
        """
      end)

      assert html =~ "Click me"
      assert html =~ "<button"
      assert html =~ "phx-submit-loading:opacity-75"
    end

    test "renders a button with custom class" do
      html = do_render(fn assigns ->
        ~H"""
        <.button class="custom-class">Submit</.button>
        """
      end)

      assert html =~ "custom-class"
      assert html =~ "Submit"
    end
  end

  describe "header/1" do
    test "renders a header with title" do
      html = do_render(fn assigns ->
        ~H"""
        <.header>My Title</.header>
        """
      end)

      assert html =~ "My Title"
      assert html =~ "<h1"
    end

    test "renders a header with subtitle" do
      html = do_render(fn assigns ->
        ~H"""
        <.header>
          My Title
          <:subtitle>My subtitle</:subtitle>
        </.header>
        """
      end)

      assert html =~ "My Title"
      assert html =~ "My subtitle"
    end
  end

  describe "icon/1" do
    test "renders a hero icon" do
      html = do_render(fn assigns ->
        ~H"""
        <.icon name="hero-x-mark-solid" class="w-5 h-5" />
        """
      end)

      assert html =~ "hero-x-mark-solid"
    end
  end

  describe "label/1" do
    test "renders a label" do
      html = do_render(fn assigns ->
        ~H"""
        <.label for="test-input">Test Label</.label>
        """
      end)

      assert html =~ "Test Label"
      assert html =~ ~s(for="test-input")
      assert html =~ "<label"
    end
  end

  describe "error/1" do
    test "renders an error message" do
      html = do_render(fn assigns ->
        ~H"""
        <.error>Something went wrong</.error>
        """
      end)

      assert html =~ "Something went wrong"
      assert html =~ "text-rose-600"
    end
  end

  describe "back/1" do
    test "renders a back link" do
      html = do_render(fn assigns ->
        ~H"""
        <.back navigate="/home">Back to home</.back>
        """
      end)

      assert html =~ "Back to home"
      assert html =~ ~s(href="/home")
    end
  end

  describe "translate_error/1" do
    test "translates simple error message" do
      assert translate_error({"is invalid", []}) == "is invalid"
    end

    test "translates error with count" do
      result = translate_error({"should be at least %{count} character(s)", [count: 5]})
      assert result =~ "5"
    end
  end
end
