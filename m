Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289339AbSAOAvV>; Mon, 14 Jan 2002 19:51:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289100AbSAOAvM>; Mon, 14 Jan 2002 19:51:12 -0500
Received: from think.faceprint.com ([166.90.149.11]:38787 "EHLO
	think.faceprint.com") by vger.kernel.org with ESMTP
	id <S289336AbSAOAvC>; Mon, 14 Jan 2002 19:51:02 -0500
Date: Mon, 14 Jan 2002 19:50:53 -0500
To: "Eric S. Raymond" <esr@thyrsus.com>, linux-kernel@vger.kernel.org
Subject: Re: Penelope builds a kernel
Message-ID: <20020115005053.GA16892@faceprint.com>
In-Reply-To: <20020114165909.A20808@thyrsus.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <20020114165909.A20808@thyrsus.com>
User-Agent: Mutt/1.3.25i
From: faceprint@faceprint.com (Nathan Walp)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 14, 2002 at 04:59:09PM -0500, Eric S. Raymond wrote:
<snip of over-many-people's-heads description of advanced biology stuff>
> Penelope needs to build a kernel to support her exotic driver, but she
> hasn't got more than the vaguest idea how to go about it.  The
> instructions with the driver source patch tell her to apply it at the
> top level of a current Linux source tree and then just say "build the
> kernel" before getting off into technicalia about the user-space
> tools.
>=20
> She could ask that guy who's been eyeing her over at the computer lab
> for help; Penelope knows what a penguin T-shirt means, and he's not
> too bad-looking, if a bit on the skinny side.  On the other hand, she
> knows that guys like that tend to take over the whole process when
> they're trying to be helpful; they can't help displaying their prowess
> and doing more than you asked for, it's biologically wired in.  And
> she's learned that letting someone else take over maintaining your
> equipment properly in a way you don't understand is a good way to have
> it flake out on you just short of a deadline.
>=20
> On the third hand, she really *doesn't* want to spend her think time
> absorbing a bunch of irrelevant hardware details just to get the one
> driver she needs up and running.  What she needs is some fast,
> hassle-free technological empowerment, not Yet Another Learning
> Experience. (And a boyfriend would be nice too, while she's wishing.)

So can we assume that our dear sweet Penelope has spent a bit of time
reading l-k and finding out about <insert your favorite brown-paper-bag
release here>?  We wouldn't want her to destroy her newly-created data.
Also, since she has a laptop (which comes with all that finicky laptop
hardware), does the release of the kernel she grabbed have that nasty
tweak that fries the board in her laptop?  (I've heard some rather nasty
horror stories, that's why I ask)

She can't very well patch her vendor kernel, because I sincerely doubt
the patch will apply cleanly, if this driver is such that it needs a
patch as opposed to just a module.

Also, what do we tell Penelope when her other piece of exotic hardware
that *was* supported in the vendor kernel, but isn't supported in the
vanilla kernel, stops working.  Suddenly she can do her advanced biology
stuff, but can't print, or dial up w/ her winmodem, or whatever.

> If Penelope learns from the README file that all *she* has to do is
> type "configure; make" to build a kernel that supports her hardware,
> she can apply that MEMS card patch and build with confidence that the
> effort is unlikely to turn into an infinite time sink.
>=20
> Autoconfigure saves the day again.  That guy in the penguin T-shirt
> might even be impressed...

If Penelope is even a remote candidate for this scenario, I think
penguin-boy is already impressed ;-)

--=20
Nathan Walp             || faceprint@faceprint.com
GPG Fingerprint:        ||   http://faceprint.com/
5509 6EF3 928B 2363 9B2B  DA17 3E46 2CDC 492D DB7E


--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8Q3ztPkYs3Ekt234RAqIoAJ9yKXRAcLcopnS1mSbk3yUAtCtwSACeIDRZ
iYY1sRV8UHm2vLq6ysHXWXM=
=/MAG
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
