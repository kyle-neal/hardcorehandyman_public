defmodule HardcorehandymanWeb.QuoteFormComponent do
  use HardcorehandymanWeb, :live_component

  alias Hardcorehandyman.Quotes
  alias Hardcorehandyman.Quotes.Quote

  def mount(socket) do
    changeset = Quotes.change_quote(%Quote{})

    # Allow at most 10 photos, 10mb each
    socket =
      allow_upload(
        socket,
        :photos,
        max_entries: 3,
        max_file_size: 10_000_000,
        accept: ~w(.jpg .jpeg .png)
      )

    {:ok, assign(socket, form: to_form(changeset))}
  end

  def handle_event("cancel", %{"ref" => ref}, socket) do
    # IO.inspect(ref, label: "ref")
    # IO.inspect(socket, label: "socket")
    socket = cancel_upload(socket, :photos, ref)
    # IO.inspect(socket, label: "new socket")
    {:noreply, socket}
  end

  def handle_event("validate", %{"quote" => p}, socket) do
    changeset =
      %Quote{}
      |> Quotes.change_quote(p)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, form: to_form(changeset))}
  end

  def handle_event("submit", %{"quote" => p}, socket) do
    IO.inspect(p, label: "SUBMIT")

    # copy temp file to priv/static/uploads/abc.png
    # URL path: /uploads/abc.png

    photo_locations =
      consume_uploaded_entries(socket, :photos, fn meta, entry ->
        # dest =
        #   Path.join([
        #     "priv",
        #     "static",
        #     "uploads",
        #     "#{entry.uuid}-#{entry.client_name}"
        #   ])
        dest = "/tmp/uploads/#{entry.uuid}-#{entry.client_name}"

        File.mkdir_p!(Path.dirname(dest))

        File.cp!(meta.path, dest)
        # url_path = static_path(socket, "/uploads/#{Path.basename(dest)}")
        {:ok, dest}
      end)

    params = Map.put(p, "photo_locations", photo_locations)

    case Quotes.create_quote(params) do
      {:error, changeset} ->
        IO.inspect(changeset, label: "ERROR")

        send(self(), {:error, changeset})

        {:noreply, assign(socket, form: to_form(changeset))}

      {:ok, quote} ->
        IO.inspect(quote, label: "CREATED")

        send(self(), {:created, quote})

        changeset = Quotes.change_quote(%Quote{})
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  def render(assigns) do
    ~H"""
    <div id="quote">
      <%!-- <pre class="text-black"><%= inspect(@form, pretty: true) %></pre> --%>
      <.form
        id="quote-form"
        phx-change="validate"
        phx-submit="submit"
        phx-target={@myself}
        for={@form}
      >
        <div class="space-y-12">
          <div class="border-b border-gray-900/10 pb-12">
            <h2 class="text-base font-semibold leading-7 text-gray-900">Start a Quote</h2>
            <p class="mt-1 text-sm leading-6 text-gray-600">
              Please provide as much detail as possible when completing this form.
            </p>

            <div class="mt-10 grid grid-cols-1 gap-x-6 gap-y-8 sm:grid-cols-6">
              <div class="sm:col-span-4">
                <label for="job_title" class="block text-sm font-medium leading-6 text-gray-900">
                  Job Title
                </label>
                <div class="mt-2">
                  <.input
                    field={@form[:job_title]}
                    placeholder="Enter a title for your job in as little words as possible"
                    autocomplete="off"
                    phx-debounce="500"
                    class="mt-2 w-full rounded-lg border-zinc-300 py-[7px] px-[11px] text-zinc-900 focus:border-zinc-400 focus:outline-none focus:ring-4 focus:ring-zinc-800/5 sm:text-sm sm:leading-6 border-zinc-300 focus:border-zinc-400 focus:ring-zinc-800/5"
                  />
                </div>
              </div>

              <div class="col-span-full">
                <label for="about" class="block text-sm font-medium leading-6 text-gray-900">
                  Description
                </label>
                <div class="mt-2">
                  <.input
                    field={@form[:description]}
                    type="textarea"
                    placeholder="Write a few sentences detailing the job you need done."
                    autocomplete="off"
                    phx-debounce="500"
                    rows={3}
                  />
                </div>
              </div>
              <div class="col-span-full">
                <label for="cover-photo" class="block text-sm font-medium leading-6 text-gray-900">
                  Upload photos for the job
                </label>
                <p class="mt-3 text-sm leading-6 text-gray-600">
                  Be as detailed as you can in your pictures. Sketches of the job are also welcome.
                </p>
                <div class="hint">
                  Add up to <%= @uploads.photos.max_entries %> photos
                  up to <%= @uploads.photos.max_file_size / 1_000_000 %> MB each.
                </div>
                <div class="drop" phx-drop-target={@uploads.photos.ref}>
                  <div>
                    <img src={~p"/images/upload.svg"} />
                    <div>
                      <label for={@uploads.photos.ref}>
                        <span>Upload a file</span>
                        <.live_file_input upload={@uploads.photos} class="sr-only" />
                      </label>
                      <span>or drag and drop here</span>
                    </div>
                    <p>
                      <%= @uploads.photos.max_entries %> photos max,
                      up to <%= trunc(@uploads.photos.max_file_size / 1_000_000) %> MB each
                    </p>
                  </div>
                </div>
                <.error :for={err <- upload_errors(@uploads.photos)}>
                  <%= Phoenix.Naming.humanize(err) %>
                </.error>
                <div :for={entry <- @uploads.photos.entries} class="entry">
                  <.live_img_preview entry={entry} />
                  <%!--
                  <div class="progress">
                    <div class="value">
                      <%= entry.progress %>%
                    </div>

                    <div class="bar">
                      <span style={"widght: #{entry.progress}%"}></span>
                    </div>

                    <.error :for={err <- upload_errors(@uploads.photos, entry)}>
                      <%= Phoenix.Naming.humanize(err) %>
                    </.error>
                  </div> --%>

                  <a phx-click="cancel" phx-value-ref={entry.ref} phx-target={@myself}>
                    &times;
                  </a>
                </div>
              </div>
            </div>
          </div>

          <div class="border-b border-gray-900/10 pb-12">
            <h2 class="text-base font-semibold leading-7 text-gray-900">Personal Information</h2>
            <p class="mt-1 text-sm leading-6 text-gray-600">
              Please use the address of the work being requested.
            </p>

            <div class="mt-10 grid grid-cols-1 gap-x-6 gap-y-8 sm:grid-cols-6">
              <div class="sm:col-span-3">
                <label for="first-name" class="block text-sm font-medium leading-6 text-gray-900">
                  First name
                </label>
                <div class="mt-2">
                  <.input
                    field={@form[:fname]}
                    placeholder="First name"
                    autocomplete="off"
                    phx-debounce="500"
                    class="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-blue-600 sm:text-sm sm:leading-6"
                  />
                </div>
              </div>

              <div class="sm:col-span-3">
                <label for="last-name" class="block text-sm font-medium leading-6 text-gray-900">
                  Last name
                </label>
                <div class="mt-2">
                  <.input
                    field={@form[:lname]}
                    placeholder="Last name"
                    autocomplete="off"
                    phx-debounce="500"
                    class="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-blue-600 sm:text-sm sm:leading-6"
                  />
                </div>
              </div>

              <div class="sm:col-span-4">
                <label for="email" class="block text-sm font-medium leading-6 text-gray-900">
                  Email address
                </label>
                <div class="mt-2">
                  <.input
                    field={@form[:email]}
                    placeholder="Email address"
                    autocomplete="off"
                    phx-debounce="500"
                    class="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-blue-600 sm:text-sm sm:leading-6"
                  />
                </div>
              </div>

              <div class="z-0">
                <label for={@form[:phone].name} class="block text-sm font-medium text-gray-900">
                  Phone Number
                </label>
                <div class="relative mt-2 rounded-md shadow-sm">
                  <%!-- <.input
                    type="text"
                    field={@form[:phone]}
                    class="block w-full rounded-md border-0 py-1.5 text-gray-900 ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
                    placeholder="5555555555"
                  /> --%>
                  <.input
                    field={@form[:phone]}
                    type="tel"
                    placeholder="Phone"
                    autocomplete="off"
                    phx-debounce="blur"
                    phx-hook="PhoneNumber"
                    class="block w-full rounded-md border-0 py-1.5 text-gray-900 ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
                  />
                </div>
              </div>

              <div class="col-span-full">
                <label for="street-address" class="block text-sm font-medium leading-6 text-gray-900">
                  Street address
                </label>
                <div class="mt-2">
                  <.input
                    field={@form[:addr]}
                    placeholder="Street address"
                    autocomplete="off"
                    phx-debounce="500"
                    class="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-blue-600 sm:text-sm sm:leading-6"
                  />
                </div>
              </div>

              <div class="sm:col-span-2 sm:col-start-1">
                <label for="city" class="block text-sm font-medium leading-6 text-gray-900">
                  City
                </label>
                <div class="mt-2">
                  <.input
                    field={@form[:city]}
                    placeholder="City"
                    autocomplete="off"
                    phx-debounce="500"
                    class="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-blue-600 sm:text-sm sm:leading-6"
                  />
                </div>
              </div>

              <div class="sm:col-span-2">
                <label for="region" class="block text-sm font-medium leading-6 text-gray-900">
                  State / Province
                </label>
                <div class="mt-2">
                  <.input
                    field={@form[:state]}
                    placeholder="State"
                    autocomplete="off"
                    phx-debounce="500"
                    class="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-blue-600 sm:text-sm sm:leading-6"
                  />
                </div>
              </div>

              <div class="sm:col-span-2">
                <label for="postal-code" class="block text-sm font-medium leading-6 text-gray-900">
                  ZIP / Postal code
                </label>
                <div class="mt-2">
                  <.input
                    field={@form[:zip]}
                    placeholder="ZIP / Postal code"
                    autocomplete="off"
                    phx-debounce="500"
                    class="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-blue-600 sm:text-sm sm:leading-6"
                  />
                </div>
              </div>
            </div>
          </div>
          <%!-- <pre class="text-black"><%= inspect(@form, pretty: true) %></pre> --%>
          <%!-- Schedule --%>
          <div class="border-b border-gray-900/10 pb-12">
            <div class="mt-10 space-y-10">
              <fieldset id={@form[:schedule].name} form="quote-form">
                <legend class="text-sm font-semibold leading-6 text-gray-900">
                  When would you like this job done?
                </legend>
                <div class="mt-6 space-y-6">
                  <div class="relative flex gap-x-3">
                    <div class="flex h-6 items-center">
                      <.input
                        id="quote_schedule_two_weeks"
                        name={@form[:schedule].name}
                        field={@form[:schedule]}
                        type="radio"
                        value={:two_weeks}
                        checked={@form[:schedule].value == :two_weeks}
                        class="h-4 w-4 rounded border-gray-300 text-blue-600 focus:ring-blue-600"
                      />
                    </div>
                    <div class="text-sm leading-6">
                      <label for="job-timeline-two_weeks" class="font-medium text-gray-900">
                        Within the next two weeks
                      </label>
                      <p class="text-gray-500">
                        If you have a smaller job, I can normally get to you quicker.
                      </p>
                    </div>
                  </div>
                  <div class="relative flex gap-x-3">
                    <div class="flex h-6 items-center">
                      <.input
                        id="quote_schedule_two_months"
                        name={@form[:schedule].name}
                        type="radio"
                        checked={@form[:schedule].value == :two_months}
                        value={:two_months}
                        field={@form[:schedule]}
                        class="h-4 w-4 rounded border-gray-300 text-blue-600 focus:ring-blue-600"
                      />
                    </div>
                    <div class="text-sm leading-6">
                      <label for="job-timeline-two_months" class="font-medium text-gray-900">
                        Within the next two months.
                      </label>
                      <p class="text-gray-500">
                        Larger jobs that take more than a day must be scheduled in advance.
                      </p>
                    </div>
                  </div>
                  <div class="relative flex gap-x-3">
                    <div class="flex h-6 items-center">
                      <.input
                        id="quote_schedule_no_timeline"
                        name={@form[:schedule].name}
                        field={@form[:schedule]}
                        type="radio"
                        checked={@form[:schedule].value == :no_timeline}
                        value={:no_timeline}
                        class="h-4 w-4 rounded border-gray-300 text-blue-600 focus:ring-blue-600"
                      />
                    </div>
                    <div class="text-sm leading-6">
                      <label for="job-timeline-no_timeline" class="font-medium text-gray-900">
                        No timeline.
                      </label>
                      <p class="text-gray-500">
                        I'll schedule you as soon as I can!
                      </p>
                    </div>
                  </div>
                </div>
              </fieldset>
            </div>
          </div>

          <%!-- References --%>
          <div class="border-b border-gray-900/10 pb-12">
            <div class="mt-10 space-y-10">
              <fieldset id={@form[:reference].name} form="quote-form">
                <legend class="text-sm font-semibold leading-6 text-gray-900">
                  How did you hear about me?
                </legend>
                <p class="mt-1 text-sm leading-6 text-gray-600">
                  I'd love to know how you found me!
                </p>
                <div class="mt-6 space-y-6">
                  <div class="flex items-center gap-x-3">
                    <.input
                      id="quote_reference_google_search"
                      field={@form[:reference]}
                      name={@form[:reference].name}
                      type="radio"
                      value={:google_search}
                      checked={@form[:reference].value == :google_search}
                      class="h-4 w-4 border-gray-300 text-blue-600 focus:ring-blue-600"
                    />
                    <label
                      for="ref-google_search"
                      class="block text-sm font-medium leading-6 text-gray-900"
                    >
                      Google Search
                    </label>
                  </div>
                  <div class="flex items-center gap-x-3">
                    <.input
                      id="quote_reference_ad_on_vehicle"
                      field={@form[:reference]}
                      name={@form[:reference].name}
                      type="radio"
                      value={:ad_on_vehicle}
                      checked={@form[:reference].value == :ad_on_vehicle}
                      class="h-4 w-4 border-gray-300 text-blue-600 focus:ring-blue-600"
                    />
                    <label
                      for="ref-ad_on_vehicle"
                      class="block text-sm font-medium leading-6 text-gray-900"
                    >
                      Saw ad on my vehicle
                    </label>
                  </div>
                  <div class="flex items-center gap-x-3">
                    <.input
                      id="quote_reference_online_ad"
                      field={@form[:reference]}
                      name={@form[:reference].name}
                      type="radio"
                      value={:online_ad}
                      checked={@form[:reference].value == :online_ad}
                      class="h-4 w-4 border-gray-300 text-blue-600 focus:ring-blue-600"
                    />
                    <label
                      for="ref-online_ad"
                      class="block text-sm font-medium leading-6 text-gray-900"
                    >
                      Online Advertisement
                    </label>
                  </div>
                  <div class="flex items-center gap-x-3">
                    <.input
                      id="quote_reference_yelp"
                      field={@form[:reference]}
                      name={@form[:reference].name}
                      type="radio"
                      value={:yelp}
                      checked={@form[:reference].value == :yelp}
                      class="h-4 w-4 border-gray-300 text-blue-600 focus:ring-blue-600"
                    />
                    <label for="ref-yelp" class="block text-sm font-medium leading-6 text-gray-900">
                      Yelp
                    </label>
                  </div>
                  <div class="flex items-center gap-x-3">
                    <.input
                      id="quote_reference_facebook"
                      field={@form[:reference]}
                      name={@form[:reference].name}
                      type="radio"
                      value={:facebook}
                      checked={@form[:reference].value == :facebook}
                      class="h-4 w-4 border-gray-300 text-blue-600 focus:ring-blue-600"
                    />
                    <label
                      for="ref-facebook"
                      class="block text-sm font-medium leading-6 text-gray-900"
                    >
                      Facebook
                    </label>
                  </div>
                  <div class="flex items-center gap-x-3">
                    <.input
                      id="quote_reference_word_of_mouth"
                      field={@form[:reference]}
                      name={@form[:reference].name}
                      type="radio"
                      value={:word_of_mouth}
                      checked={@form[:reference].value == :word_of_mouth}
                      class="h-4 w-4 border-gray-300 text-blue-600 focus:ring-blue-600"
                    />
                    <label
                      for="ref-word_of_mouth"
                      class="block text-sm font-medium leading-6 text-gray-900"
                    >
                      Word of mouth
                    </label>
                  </div>
                </div>
              </fieldset>
            </div>
            <%!-- REFERENCE --%>
          </div>
        </div>
        <div class="col-span-full pt-4">
          <label for="about" class="block text-sm font-medium leading-6 text-gray-900">
            Subscribe to my newsletter?
          </label>
          <p class="mt-1 text-sm leading-6 text-gray-600">
            I'll send you updates on my latest projects and tips for your home. As well as great deals on some of the products I use!
          </p>
          <div class="mt-2">
            <.input field={@form[:optin]} type="checkbox" checked={true} />
          </div>
        </div>
        <div class="mt-6 flex items-center justify-end gap-x-6">
          <.button
            phx-submit="submit-quote"
            phx-disable-with="Submitting..."
            class="rounded-md bg-blue-600 px-3 py-2 text-sm font-semibold text-white shadow-sm hover:bg-blue-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-blue-600"
          >
            Submit Quote
          </.button>
        </div>
      </.form>
    </div>
    """
  end
end
