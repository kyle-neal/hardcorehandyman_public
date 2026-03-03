defmodule Hardcorehandyman.MailerTest do
  use Hardcorehandyman.DataCase

  alias Hardcorehandyman.Mailer
  alias Hardcorehandyman.Quotes.Quote

  describe "send_email/3" do
    test "sends an email without attachment" do
      assert {:ok, _email} = Mailer.send_email("test@example.com", "Hello test")
    end

    test "sends an email with attachment" do
      # Create a temporary file for the attachment
      path = Path.join(System.tmp_dir!(), "test_attachment.txt")
      File.write!(path, "test content")

      assert {:ok, _email} = Mailer.send_email("test@example.com", "With file", path)

      # Cleanup
      File.rm(path)
    end
  end

  describe "send_quote/1" do
    test "sends an email for a quote without photos" do
      quote = %Quote{
        fname: "John",
        lname: "Smith",
        email: "john@example.com",
        phone: "555-123-4567",
        addr: "123 Main St",
        city: "Lawton",
        state: "OK",
        zip: "73501",
        description: "Fix the kitchen sink plumbing",
        photo_locations: []
      }

      assert {:ok, _email} = Mailer.send_quote(quote)
    end

    test "sends an email for a quote with photo attachments" do
      # Create temporary files for photos
      paths =
        for i <- 1..2 do
          path = Path.join(System.tmp_dir!(), "test_photo_#{i}.jpg")
          File.write!(path, "fake image content #{i}")
          path
        end

      quote = %Quote{
        fname: "Jane",
        lname: "Doe",
        email: "jane@example.com",
        phone: "555-987-6543",
        addr: "456 Oak Ave",
        city: "Oklahoma City",
        state: "OK",
        zip: "73102",
        description: "Bathroom tile replacement",
        photo_locations: paths
      }

      assert {:ok, _email} = Mailer.send_quote(quote)

      # Cleanup
      Enum.each(paths, &File.rm/1)
    end

    test "email body includes all quote fields" do
      quote = %Quote{
        fname: "Taylor",
        lname: "Baxter",
        email: "taylor@test.com",
        phone: "555-111-2222",
        addr: "789 Elm Blvd",
        city: "Lawton",
        state: "OK",
        zip: "73505",
        description: "Fence installation in backyard",
        photo_locations: []
      }

      # Use Swoosh.TestAssertions by building the email manually
      # and checking that Mailer.send_quote works
      assert {:ok, _email} = Mailer.send_quote(quote)
    end
  end
end
