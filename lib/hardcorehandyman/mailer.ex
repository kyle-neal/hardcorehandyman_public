defmodule Hardcorehandyman.Mailer do
  use Swoosh.Mailer, otp_app: :hardcorehandyman
  import Swoosh.Email
  alias Hardcorehandyman.Quotes.Quote

  def send_email(receiver, body \\ "test email", file_path \\ nil)

  def send_email(receiver, body, nil) do
    new()
    |> from("emailer@revenuelink.net")
    |> to(receiver)
    |> subject("Test (no file)")
    |> text_body(body)
    |> deliver()
  end

  def send_email(receiver, body, file_path) do
    new()
    |> from("emailer@revenuelink.net")
    |> to(receiver)
    |> subject("Test (with file)")
    |> text_body(body)
    |> attachment(file_path)
    |> deliver()
  end

  def send_quote(%Quote{} = quote) do
    new()
    |> from("emailer@revenuelink.net")
    |> to("hardcorehandyman92@gmail.com")
    |> to("kyle.neal.lucidsoftwaresolutions@gmail.com")
    |> subject("Quote from #{quote.fname} #{quote.lname}")
    # Write all fields of the quote to the email body
    |> text_body("""
    Name: #{quote.fname} #{quote.lname}
    Email: #{quote.email}
    Phone: #{quote.phone}
    Address: #{quote.addr}
    City: #{quote.city}
    State: #{quote.state}
    Zip: #{quote.zip}
    Description: #{quote.description}
    """)
    # Attach all files to the email, if any
    # quote.photo_locations {:array, :string} holds
    # the file paths
    |> attachments(quote.photo_locations)
    # increase timeout to 30 seconds
    |> deliver(timeout: 30_000)
  end

  defp attachments(email, []) do
    IO.inspect(email, label: "email (in attachments)")
    email
  end

  defp attachments(email, [file_path | file_paths]) do
    attachments(email |> attachment(file_path), file_paths)
  end
end
