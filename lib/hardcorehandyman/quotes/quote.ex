defmodule Hardcorehandyman.Quotes.Quote do
  use Hardcorehandyman.Schema
  import Ecto.Changeset

  schema "quote" do
    field(:addr, :string)
    field(:city, :string)
    field(:country, :string, default: "US")
    field(:description, :string)
    field(:email, :string)
    field(:fname, :string)
    field(:job_title, :string)
    field(:lname, :string)
    field(:optin, :boolean, default: true)
    field(:photo_locations, {:array, :string})
    field(:phone, :string)

    field(:reference, Ecto.Enum,
      values: [:ad_on_vehicle, :online_ad, :google_search, :yelp, :facebook, :word_of_mouth]
    )

    field(:schedule, Ecto.Enum, values: [:two_weeks, :two_months, :no_timeline])
    field(:state, :string)
    field(:zip, :string)

    timestamps()
  end

  @doc false
  def changeset(quote, attrs) do
    quote
    |> cast(attrs, [
      :job_title,
      :description,
      :photo_locations,
      :fname,
      :lname,
      :email,
      :country,
      :addr,
      :city,
      :state,
      :zip,
      :schedule,
      :reference,
      :optin,
      :phone
    ])
    |> validate_required([
      :job_title,
      :description,
      :fname,
      :lname,
      :email,
      :addr,
      :city,
      :state,
      :zip,
      :schedule,
      :reference,
      :optin,
      :phone
    ])
    |> validate_email(:email)
    # Ensure TLD on email
    |> validate_format(:email, ~r/@.*\./)
    |> validate_length(:description, min: 10, max: 500)
    |> validate_length(:job_title, min: 5, max: 50)
    |> validate_length(:fname, min: 2, max: 50)
    |> validate_length(:lname, min: 2, max: 50)
    |> validate_length(:addr, min: 5, max: 100)
    |> validate_length(:city, min: 2, max: 50)
    |> validate_length(:state, min: 2, max: 2)
    |> validate_length(:zip, min: 5, max: 10)
    |> validate_length(:phone, min: 10, max: 20)
    ## Validate phone in correct format
    |> validate_format(:phone, ~r/^\+?(\d{1,2})?[-. ]?\(?(\d{3})\)?[-. ]?(\d{3})[-. ]?(\d{4})$/)
  end
end
