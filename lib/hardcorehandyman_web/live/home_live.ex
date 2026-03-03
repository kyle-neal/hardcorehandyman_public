defmodule HardcorehandymanWeb.HomeLive do
  use HardcorehandymanWeb, :live_view

  # This prevents compiler error because it doesn’t recognize the x- prefix in things like x-click.
  # See: https://hexdocs.pm/phoenix_live_view/Phoenix.Component.html
  use Phoenix.Component, global_prefixes: ~w(x-)

  ### ===================================================================
  ### Mount
  ### ===================================================================

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  ### ===================================================================
  ### Handle Events
  ### ===================================================================

  ### ===================================================================
  ### Render
  ### ===================================================================

  def render(assigns) do
    ~H"""
    <div id="home">
      <section id="intro" class="overflow-y-hidden">
        <.intro />
      </section>
      <%!-- <section>
        <div>
          <h1>Below me is an svg</h1>
          <.hh_icon width="50" height="50" />
        </div>
      </section> --%>
      <section id="virtualquote">
        <.virtualquote />
      </section>
      <section id="pastjobs">
        <.pastjobs />
      </section>
      <section id="services">
        <.services />
      </section>
      <section id="whoiam">
        <.whoiam />
      </section>
      <section id="revenuelink">
        <.revenuelink />
      </section>
    </div>
    """
  end

  ### ===================================================================
  ### Components
  ### ===================================================================

  defp revenuelink(assigns) do
    ~H"""
    <div class="bg-black-900 py-24 sm:py-32">
      <div class="relative isolate">
        <div class="mx-auto max-w-7xl sm:px-6 lg:px-8">
          <div class="mx-auto flex max-w-2xl flex-col gap-16 bg-white/5 px-6 py-16 ring-1 ring-white/10 sm:rounded-3xl sm:p-8 lg:mx-0 lg:max-w-none lg:flex-row lg:items-center lg:py-20 xl:gap-x-20 xl:px-20">
            <img
              class="h-96 w-full flex-none rounded-2xl object-cover shadow-xl lg:aspect-square lg:h-auto lg:max-w-sm"
              src={~p"/images/revenuelink_main.png"}
              alt=""
            />
            <div class="w-full flex-auto">
              <h2 class="text-3xl font-bold tracking-tight text-white sm:text-4xl">
                Need a website, or app for your business?
              </h2>
              <p class="mt-6 text-lg leading-8 text-gray-300">
                Trust RevenueLink Technologies, your expert partner in web design, software development, and consulting. With a decade of industry experience, we specialize in crafting beautiful, responsive, and modern websites, just like this one. Our comprehensive services extend beyond just getting your business online. We strategically position you in front of your customers, ensuring your digital presence aligns with your business goals. Let us help you connect with your audience and drive your business forward.
              </p>
              <ul
                role="list"
                class="mt-10 grid grid-cols-1 gap-x-8 gap-y-3 text-base leading-7 text-white sm:grid-cols-2"
              >
                <li class="flex gap-x-3">
                  <svg
                    class="h-7 w-5 flex-none"
                    viewBox="0 0 20 20"
                    fill="currentColor"
                    aria-hidden="true"
                  >
                    <path
                      fill-rule="evenodd"
                      d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.857-9.809a.75.75 0 00-1.214-.882l-3.483 4.79-1.88-1.88a.75.75 0 10-1.06 1.061l2.5 2.5a.75.75 0 001.137-.089l4-5.5z"
                      clip-rule="evenodd"
                    />
                  </svg>
                  Beautiful, modern, and responsive website designs with simple pricing
                </li>
                <li class="flex gap-x-3">
                  <svg
                    class="h-7 w-5 flex-none"
                    viewBox="0 0 20 20"
                    fill="currentColor"
                    aria-hidden="true"
                  >
                    <path
                      fill-rule="evenodd"
                      d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.857-9.809a.75.75 0 00-1.214-.882l-3.483 4.79-1.88-1.88a.75.75 0 10-1.06 1.061l2.5 2.5a.75.75 0 001.137-.089l4-5.5z"
                      clip-rule="evenodd"
                    />
                  </svg>
                  Specializing in custom software designs, from innovative new apps to enhancing existing systems.
                </li>
                <li class="flex gap-x-3">
                  <svg
                    class="h-7 w-5 flex-none"
                    viewBox="0 0 20 20"
                    fill="currentColor"
                    aria-hidden="true"
                  >
                    <path
                      fill-rule="evenodd"
                      d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.857-9.809a.75.75 0 00-1.214-.882l-3.483 4.79-1.88-1.88a.75.75 0 10-1.06 1.061l2.5 2.5a.75.75 0 001.137-.089l4-5.5z"
                      clip-rule="evenodd"
                    />
                  </svg>
                  Boost your company's revenue with our expert consulting advice for your technical issues, tailored to drive business growth and success.
                </li>
              </ul>
              <div class="mt-10 flex">
                <a
                  href="https://revenuelink.net"
                  class="text-sm font-semibold leading-6 text-indigo-400"
                >
                  Learn more <span aria-hidden="true">&rarr;</span>
                </a>
              </div>
            </div>
          </div>
        </div>
        <div
          class="absolute inset-x-0 -top-16 -z-10 flex transform-gpu justify-center overflow-hidden blur-3xl"
          aria-hidden="true"
        >
          <div
            class="aspect-[1318/752] w-[82.375rem] flex-none bg-gradient-to-r from-[#80caff] to-[#4f46e5] opacity-25"
            style="clip-path: polygon(73.6% 51.7%, 91.7% 11.8%, 100% 46.4%, 97.4% 82.2%, 92.5% 84.9%, 75.7% 64%, 55.3% 47.5%, 46.5% 49.4%, 45% 62.9%, 50.3% 87.2%, 21.3% 64.1%, 0.1% 100%, 5.4% 51.1%, 21.4% 63.9%, 58.9% 0.2%, 73.6% 51.7%)"
          >
          </div>
        </div>
      </div>
    </div>
    """
  end

  defp virtualquote(assigns) do
    ~H"""
    <div class="py-8">
      <div class="px-4 py-16 mx-auto sm:max-w-xl md:max-w-full lg:max-w-screen-xl md:px-24 lg:px-8 lg:py-20">
        <div class="max-w-xl mb-10 md:mx-auto sm:text-center lg:max-w-2xl md:mb-12">
          <h2 class="mb-6 font-sans text-3xl font-bold leading-none tracking-tight max-w-xl text-white sm:text-4xl md:mx-auto">
            Get a free virtual quote!
          </h2>
          <p class="text-base md:text-lg">
            It's easy and free to get an estimate for your next project using a virtual quote. If an in-person
            walk through is required a $50 charge will be made. But don't worry,
            this charge counts against your final bill if you decide to get the
            work done.
          </p>
        </div>
        <div class="grid gap-8 row-gap-5 md:row-gap-8 lg:grid-cols-3">
          <div class="p-5 duration-300 transform bg-gray-900 border-2 border-dashed shadow-sm hover:-translate-y-2 border-primary-500 rounded-global">
            <div class="flex items-center mb-2">
              <p class="flex items-center justify-center w-10 h-10 mr-2 text-lg font-bold text-white rounded-full bg-blue-500">
                1
              </p>
              <p class="text-lg font-bold leading-5">Fill the form</p>
            </div>
            <p class="text-sm">
              The form is setup in a way to clearly portray to me the work that
              you're looking for, saving us both time!
            </p>
          </div>
          <div class="p-5 duration-300 transform bg-gray-900 border-2 border-dashed shadow-sm hover:-translate-y-2 border-primary-500 rounded-global">
            <div class="flex items-center mb-2">
              <p class="flex items-center justify-center w-10 h-10 mr-2 text-lg font-bold text-white rounded-full bg-blue-500">
                2
              </p>
              <p class="text-lg font-bold leading-5">Submit pictures</p>
            </div>
            <p class="text-sm">
              The more pictures the better, it helps me understand what you're
              looking for!
            </p>
          </div>
          <div class="relative p-5 duration-300 transform bg-gray-900 border-2 shadow-sm hover:-translate-y-2 border-primary-500 rounded-global">
            <div class="flex items-center mb-2">
              <p class="flex items-center justify-center w-10 h-10 mr-2 text-lg font-bold text-white rounded-full bg-blue-500">
                3
              </p>
              <p class="text-lg font-bold leading-5">Get your estimate!</p>
            </div>
            <p class="text-sm">
              For any inquiry, you're guaranteed to hear back in 3-5 business
              days!
            </p>
            <p class="absolute top-0 right-0 flex items-center justify-center w-8 h-8 -mt-4 -mr-4 font-bold rounded-full bg-blue-500 sm:-mt-5 sm:-mr-5 sm:w-10 sm:h-10">
              <span class="w-fit">
                <svg class="text-white w-7" stroke="currentColor" viewBox="0 0 24 24">
                  <polyline
                    fill="none"
                    stroke-width="2"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    stroke-miterlimit="10"
                    points="6,12 10,16 18,8"
                  >
                  </polyline>
                </svg>
              </span>
            </p>
          </div>
        </div>
      </div>
      <div class="body-font-900 bg-primary-500 md:block text-center py-10 px-4 bg-primary-500 md:w-10/12 md:mx-auto lg:w-2/3">
        <h1 class="flex-grow text-2xl font-medium title-font text-center text-white">
          Let's get started
        </h1>
        <div class="mt-5 xl:text-center xl:mt-6">
          <.link navigate={~p"/quote"}>
            <button class="bg-blue-700 !important text-white px-4 py-2 rounded-lg font-semibold">
              Start A Virtual Quote
            </button>
          </.link>
        </div>
      </div>
    </div>
    """
  end

  defp pastjobs(assigns) do
    ~H"""
    <div class="px-4 xl:max-w-7xl xl:mx-auto">
      <div class="flex flex-wrap w-full px-4 pb-5 dark:my-[18px] dark:py-0">
        <div class="lg:w-1/2 w-full mb-6 lg:mb-0">
          <h1 class="text-3xl title-font mb-2 text-white font-bold dark:text-slate-100 sm:text-4xl">
            Past Jobs
          </h1>
          <p class="mt-3 text-lg dark:ml-[13px] sm:max-w-lg sm:mx-auto">
            See why my customers are happy
          </p>
          <div class="h-1 rounded bg-primary w-14">
            <div class="p-2"></div>
          </div>
        </div>
      </div>
      <div class="grid grid-cols-3 gap-2 mt-7 sm:px-16">
        <div class="col-span-3 md:col-span-2">
          <img class="w-full bg-blue-50" src={~p"/images/pastjobs4.png"} />
        </div>
        <div class="col-span-3 md:col-span-1">
          <img class="w-full bg-blue-50" src={~p"/images/pastjobs2.png"} />
        </div>
        <div class="col-span-3 md:col-span-1">
          <img class="w-full bg-blue-50" src={~p"/images/pastjobs3.png"} />
        </div>
        <div class="col-span-3 md:col-span-2">
          <img class="w-full bg-blue-50" src={~p"/images/pastjobs1.png"} />
        </div>
      </div>
    </div>
    """
  end

  defp whoiam(assigns) do
    ~H"""
    <div class="py-24 md:py-32">
      <div class="mx-auto grid max-w-7xl grid-cols-1 gap-x-8 gap-y-20 px-6 lg:px-8 xl:grid-cols-5">
        <div class="max-w-2xl xl:col-span-2">
          <h2 class="text-3xl font-bold tracking-tight text-white sm:text-4xl">Who I am</h2>
          <p class="mt-6 text-lg leading-8 text-white">
            Hello, I'm Taylor, and I take pride in being a devoted husband, firefighter,
            and handyman. Inspired by my father's guidance during my childhood, I developed
            a passion for hands-on work. Over a decade ago, I purchased my first home in downtown Lawton.
            Built in the 1940s, my current residence posed significant challenges upon my acquisition.
            While it appeared satisfactory at first glance, it didn't take long for me to unveil a host
            of lurking hazards concealed within its walls. Determined to make it safe, I rolled up my
            sleeves and embarked on my handyman journey.  That first project taught me valuable skills
            and invaluable lessons, emphasizing the satisfaction of a job well done. Since then, my focus
            has been on delivering happiness to my clients. I genuinely hope to have the opportunity to
            make you my next satisfied customer.
          </p>
        </div>
        <ul role="list" class="-mt-12 space-y-12 divide-y divide-gray-200 xl:col-span-3">
          <li class="flex flex-col gap-10 pt-12 sm:flex-row">
            <img
              class="aspect-[4/5] w-80 flex-none rounded-2xl object-cover"
              src={~p"/images/tayportrait7.jpg"}
              alt=""
            />
            <div class="max-w-xl flex-auto">
              <h3 class="text-lg font-semibold leading-8 tracking-tight text-white">
                Taylor Baxter
              </h3>
              <p class="text-base leading-7 text-white">Owner and Operator</p>
              <ul role="list" class="mt-6 flex gap-x-6">
                <li>
                  <a
                    href="https://z-upload.facebook.com/HardcoreHandyman92/about/?referrer=services_landing_page"
                    class="text-blue-400 hover:text-blue-500"
                  >
                    <span class="sr-only">FaceBook</span>
                    <.facebook_icon />
                  </a>
                </li>
              </ul>
            </div>
          </li>
          <!-- More people... -->
        </ul>
      </div>
    </div>
    """
  end

  defp intro(assigns) do
    ~H"""
    <div class="grid gap-5 row-gap-8 lg:grid-cols-2 text-white ">
      <div class="box-border flex flex-col justify-center">
        <img class="h-full w-full" src={~p"/images/tayportrait9.jpg"} />
      </div>
      <div class="pl-10 flex flex-col justify-center">
        <div class="max-w-xl mb-6">
          <h2 class="max-w-lg mb-6 font-sans text-3xl font-bold tracking-tight text-slate-900 dark:text-slate-100 sm:text-4xl sm:leading-none">
            <span class="text-white">Need work done around the house?</span>
            <br />
          </h2>
          <p class="text-base md:text-lg">
            We all know how chaotic life can get, leaving us little room to handle the small
            chores and repairs at home. That's where I come in to offer my assistance.
            With 7 years of experience in contracting, I've heard one recurring complaint about
            contractors: poor communication. It's disheartening when you can't find someone
            reliable and responsive. My approach is different. Communication is my top priority,
            ensuring that you're always in the loop. And when it comes to the work itself,
            you can count on me to deliver exceptional craftsmanship.
          </p>
        </div>
        <div class="grid gap-5 row-gap-8 sm:grid-cols-2">
          <div class="border-l-4 border-blue-500">
            <div class="h-full p-5 border border-l-0 rounded-r bg-gray-900">
              <h6 class="mb-2 font-semibold text-white">
                Finding reliable contractors can be challenging.
              </h6>
              <p class="text-sm text-white">
                I am committed to clear communication and delivering exceptional workmanship to help you reclaim the joy in your home.
              </p>
            </div>
          </div>
          <div class="shadow-sm border-l-4 border-blue-500">
            <div class="h-full p-5 border border-l-0 rounded-r bg-gray-900">
              <h6 class="mb-2 font-semibold text-white">
                Setting a new standard.
              </h6>
              <p class="text-sm pb-5 text-white">
                With my virtual quote system, you can save time and effortlessly request service calls, renovations, and more!
              </p>
              <a href="/quote">
                <button class="bg-blue-700 text-white px-4 py-2 rounded-lg font-semibold">
                  Start a Virtual Quote
                </button>
              </a>
            </div>
          </div>
        </div>
      </div>
    </div>
    """
  end

  defp services(assigns) do
    ~H"""
    <div class="mx-auto max-w-7xl">
      <div class="flex flex-wrap w-full px-4 pb-5 dark:my-[18px] dark:py-0">
        <div class="lg:w-1/2 w-full mb-6 lg:mb-0">
          <h1 class="text-3xl title-font mb-2 text-white font-bold dark:text-slate-100 sm:text-4xl">
            What do I do?
          </h1>
          <div class="h-1 rounded bg-primary w-14">
            <div class="p-2"></div>
          </div>
        </div>
      </div>
      <div class="flex flex-wrap">
        <div class="p-4 md:w-1/2 xl:w-1/4">
          <div>
            <img
              class="h-40 rounded w-full object-cover object-center mb-2 xl:mb-0"
              src={~p"/images/kitchen.png"}
            />
            <div class="p-6 rounded-lg dark:divide-undefined">
              <h2 class="text-lg text-white title-font mb-0 font-heading font-semibold dark:divide-undefined dark:divide-undefined dark:text-gray-200">
                Kitchen
              </h2>
              <ul>
                <li>Appliance Installation</li>
                <li>Backsplashes</li>
                <li>Minor plumbing</li>
                <li>Caulk and Paint</li>
                <li>Pre-Built Cabinet Installs</li>
                <li>Flooring</li>
              </ul>
            </div>
          </div>
        </div>
        <div class="p-4 md:w-1/2 xl:w-1/4">
          <div>
            <img
              class="h-40 rounded w-full object-cover object-center mb-2 xl:mb-0"
              src={~p"/images/bathroom.png"}
            />
            <div class="p-6 rounded-lg dark:divide-undefined">
              <h2 class="text-lg text-white title-font mb-0 font-heading font-semibold dark:divide-undefined dark:divide-undefined dark:text-gray-200">
                Bathroom
              </h2>
              <ul>
                <li>Custom Shower Installation</li>
                <li>Backsplashes</li>
                <li>Minor plumbing</li>
                <li>Caulk and Paint</li>
                <li>Toilet Repair</li>
                <li>Bathroom Fan Repair</li>
                <li>Flooring</li>
              </ul>
            </div>
          </div>
        </div>
        <div class="p-4 md:w-1/2 xl:w-1/4">
          <div>
            <div class="p-6 rounded-lg dark:divide-undefined">
              <h2 class="text-lg text-white title-font mb-0 font-heading font-semibold dark:divide-undefined dark:divide-undefined dark:text-gray-200">
                Other
              </h2>
              <ul>
                <li>Fence Installation/Repair</li>
                <li>Carpentry</li>
                <li>Door Installation</li>
                <li>Drywall Repairs</li>
                <li>Painting</li>
                <li>Electrical Outlets and Switch Covers</li>
                <li>Lighting Fixtures</li>
                <li>Cleaning Services</li>
                <li>AC Unit Installation/Repair</li>
                <li>Garage Door Repairs</li>
                <li>TV Mounting Services</li>
                <li>Outdoor Construction/Repairs</li>
                <li>Much, much more!</li>
              </ul>
            </div>
          </div>
        </div>
        <div class="p-4 md:w-1/2 xl:w-1/4">
          <div>
            <div class="p-6 rounded-lg dark:divide-undefined">
              <h2 class="text-lg text-white title-font mb-0 font-heading font-semibold dark:divide-undefined dark:divide-undefined dark:text-gray-200">
                What I don't do
              </h2>
              <ul>
                <li>In-wall plumbing/electrical</li>
                <li>Breaker box service</li>
                <li>Outlet/circuit installation</li>
                <li>Gas appliances</li>
                <li>Gas fitting</li>
                <li>Water heater installation</li>
                <li>Large drywall jobs</li>
                <li>Large tile jobs (200+ sqft)</li>
                <li>Occupied home painting</li>
                <li>Steep roof work</li>
                <li>Add-ons to structures</li>
                <li>Shower/tub refinishing</li>
                <li>Countertop installation</li>
                <li>Appliance repair</li>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </div>
    """
  end
end
