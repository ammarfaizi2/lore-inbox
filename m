Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268060AbTBMPY6>; Thu, 13 Feb 2003 10:24:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268061AbTBMPY6>; Thu, 13 Feb 2003 10:24:58 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:63211 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S268060AbTBMPY4>;
	Thu, 13 Feb 2003 10:24:56 -0500
Subject: Re: 2.5.60 cheerleading...
From: Paul Larson <plars@linuxtestproject.org>
To: Edesio Costa e Silva <edesio@ieee.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Edesio Costa e Silva <edesio@task.com.br>
In-Reply-To: <20030212173300.A31055@master.softaplic.com.br>
References: <3E4A6DBD.8050004@pobox.com> <1045075415.22295.46.camel@plars> 
	<20030212173300.A31055@master.softaplic.com.br>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-KHf0+9dM8HiUBoW2YlGr"
X-Mailer: Ximian Evolution 1.0.5 
Date: 13 Feb 2003 09:29:12 -0600
Message-Id: <1045150153.28493.10.camel@plars>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-KHf0+9dM8HiUBoW2YlGr
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-02-12 at 13:33, Edesio Costa e Silva wrote:
> On Wed, Feb 12, 2003 at 12:43:34PM -0600, Paul Larson wrote:
> > This brings up an interesting point.  It seems like it's very common to
> > have a release that doesn't boot, or produces immediately obvious
> > problems.  I'm curious if you do any testing (LTP or otherwise) on the
> > kernels you intend to release.
>=20
> In the words of our fearless leader:
>=20
>     "regression testing"? What's that? If it compiles, it is good,
>     if it boots up it is perfect.
It would be nice if that were true, but back here in reality things are
rarely if ever even stable enough for testing if they merely build and
boot.

If Linus really is building and booting every kernel prior to release,
it would be quick and simple to add a fast subset of LTP to the mix and
do a quick regression run.  It's convenient, fast and could save a lot
of headaches for a lot of people later on.

-Paul Larson

--=-KHf0+9dM8HiUBoW2YlGr
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEABECAAYFAj5LucgACgkQbkpggQiFDqdEGQCcCkJZ81+IG6Vc8LeugXSphKsY
eTsAnjfGOT8O+NYqIkJO8oYC1KkEHGOA
=e/iq
-----END PGP SIGNATURE-----

--=-KHf0+9dM8HiUBoW2YlGr--

