Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266800AbRGFS7q>; Fri, 6 Jul 2001 14:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266801AbRGFS7i>; Fri, 6 Jul 2001 14:59:38 -0400
Received: from cx661141-c.dt1.sdca.home.com ([24.251.135.109]:13835 "HELO
	ultraviolet.org") by vger.kernel.org with SMTP id <S266800AbRGFS72>;
	Fri, 6 Jul 2001 14:59:28 -0400
Date: Fri, 6 Jul 2001 11:59:43 -0700
From: Tracy R Reed <treed@ultraviolet.org>
To: Ben Ford <ben@kalifornia.com>
Cc: jesse@cats-chateau.net, kmw@rowsw.com, J Sloan <jjs@mirai.cx>,
        linux-kernel@vger.kernel.org
Subject: Re: Uncle Sam Wants YOU!
Message-ID: <20010706115943.G13383@ultraviolet.org>
Mail-Followup-To: Tracy R Reed <treed@ultraviolet.org>,
	Ben Ford <ben@kalifornia.com>, jesse@cats-chateau.net,
	kmw@rowsw.com, J Sloan <jjs@mirai.cx>, linux-kernel@vger.kernel.org
In-Reply-To: <200107011602.MAA01357@smarty.smart.net> <01070114030902.14899@zaphodbeeblebrox> <01070115092401.00290@tabby> <01070115181502.00290@tabby> <3B3FB7F5.6080008@kalifornia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="lHGcFxmlz1yfXmOs"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B3FB7F5.6080008@kalifornia.com>; from ben@kalifornia.com on Sun, Jul 01, 2001 at 04:53:25PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lHGcFxmlz1yfXmOs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 01, 2001 at 04:53:25PM -0700, Ben Ford wrote:
> I seem to recall that MS products cannot be used in aircraft control=20
> rooms for this reason.

Your statement above is not necessarily true. By control rooms do you mean
control towers or in the aircraft themselves? Inside the aircraft itself
is obviously the more critical situation and NT is being used there so I
don't see why it wouldn't be used in the air traffic control system as
well whether it be in control towers, air route traffic control centers,
or wherever.

MS products are used in life-critical situations.  First, there was the
USS Yorktown. But that was just a test situation. =20

Here is an NT system used in a real non-test and FAA certified situation.
It operates the primary flight instruments of a high-performance aircraft.
There are several certified aircraft using this unit. I can't remember the
others I've read about but this is the Lancair Columbia 400.

=46rom http://www.avweb.com/articles/colum400/ :

>Stationary is the word until the system boots -- perhaps like the computer
>you're using to read this -- and the solid-state AHARS (attitude, heading
>and reference system) sensors orient. Of course, this slight delay (the
>avionics system uses an even more stable version of Microsoft's
>almost-bulletproof Windows NT) generally won't pose a problem during cold
>starts -- particularly cold-weather cold starts.

I gasped aloud when I read "almost-bulletproof Windows NT".

As a pilot who flies people into the clouds regularly (San Diego usually
has good weather but only after the marine layer clears) I can tell you
that a reliable attitude indicator (AI) is an absolute life-critical
necessity. Without one, you are in serious trouble. When inside a cloud
without visual reference to the ground all you see out the windows is
whiteness. It's like being on the inside of a giant white sphere with no
markings whatsoever. Or blackness if at night. If the attitude indicator
fails vertigo often sets in as you can't tell which way is up as your
brain, confused by the unnatural state of not having any visual reference
to the horizon, tells you incorrect things. You can't just drop a penny
and see which way it falls or hang a string from the ceiling and see which
way it hangs or look at the level of water in a glass to see what is
level. The aircraft will be turning steeply (left or right, you have no
way of knowing and banking the aircraft the wrong way will only make it
much worse very fast) which means it is being accelerated towards the
inside of the turn so the penny may fall straight down, the string may
hang straight, and the water in the glass might be level. Whatever these
things are doing, they won't be right. You will be descending very quickly
now since the lift of the steeply banked wings is being generated
horizontally instead of vertically, tightening the turn. This continues
until impact. You have absolutely no way to tell which way is up or which
way you are turning without a stable gyroscopic reference. It is my (and
every pilots) worst nightmare when flying in clouds or anytime the outside
horizon is not clearly visible.

Yes, there are instruments which can be used to derive attitude
information such as rate of turn, altimeter, vertical speed indicator,
etc. (assuming they aren't driven by the same crashed computer as the AI)
and this is standard procedure in the case of AI failure but it takes lots
of practice to be able to use them because the information they provide
you with is indirect and requires interpretation. Not an easy thing to do
when you know you are in serious trouble. Missouri Governer Mel Carnahan
was killed in a plane crash recently where the attitude indicator failed
and the pilot had to interpret the other instruments to get attitude info
and wasn't able to cut it. The article quoted above claims that this is a
special version of NT that really is stable...no we really mean it this
time! Why they don't make this especially stable version available to
consumers is beyond me...oh wait, I know why: because it's really just the
same code everyone runs on their servers and desktops! Fortunately, this
system only runs for a few hours at a time and gets shut down/rebooted
after every flight. It also runs only one application and never has any
new software installed or uninstalled. No network access either. That
should help a lot with reliability. I hope this thing doesn't have a hard
drive in it. The gyroscopic effects on the platter of a pitching aircraft
can't be good for the bearings. This equipment is so expensive that it is
expected to last many years, even decades. Who is going to support NT 20
years from now? This setup was approved and certified for use by the FAA.
I wonder if any software engineers looked at it? I'll have to find out
what criteria they use for certifying this sort of thing. It must use an
x86 processor too. I sure hope it has good cooling. I've already had one
avionics failure due to overheating (a cooling duct came loose behind the
instrument panel and I lost the whole radio stack so there was no way to
get clearances or anything) and I would really hate for it to happen in
instrument conditions!

I'm all for modernizing the cockpit with computers. Putting all of the
flight info onto a flat panel display is very useful. Some airplanes I've
flown are 30 years old with instruments that really look it.=20

Which leads me to wonder: Would I trust Linux in this situation?

More so than NT but I still don't know what my first choice would really
be given that death is a possibility if it fails at an inopportune time.

In three hours I depart for a flight over open ocean with potential
visibility restrictions (still need to get the weather briefing). I better
do a thorough preflight and make sure all inspections are current.
Wouldn't want to pull a Kennedy!

--=20
Tracy Reed      http://www.ultraviolet.org
"Bill Gates is a white Persian cat and a monocle away from becoming another
James Bond villain."
"No Mr Bond, I expect you to upgrade." --Dennis Miller

--lHGcFxmlz1yfXmOs
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjtGCp8ACgkQ9PIYKZYVAq0DpQCdFO56+12Mp7nAglFZRIIVebg0
yggAnjOHV6fub3JQzk+c4NKW4JwsiWN0
=CufB
-----END PGP SIGNATURE-----

--lHGcFxmlz1yfXmOs--
