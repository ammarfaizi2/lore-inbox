Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268130AbTBMSAm>; Thu, 13 Feb 2003 13:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268135AbTBMSAm>; Thu, 13 Feb 2003 13:00:42 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:25234 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S268130AbTBMSAk>;
	Thu, 13 Feb 2003 13:00:40 -0500
Subject: Re: 2.5.60 cheerleading...
From: Paul Larson <plars@linuxtestproject.org>
To: John Bradford <john@grabjohn.com>
Cc: davej@codemonkey.org.uk, edesio@ieee.org,
       lkml <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>, edesio@task.com.br
In-Reply-To: <200302131711.h1DHBduR014118@darkstar.example.net>
References: <200302131711.h1DHBduR014118@darkstar.example.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-EhMdcDV4AD4bdQYBSvHQ"
X-Mailer: Ximian Evolution 1.0.5 
Date: 13 Feb 2003 12:04:43 -0600
Message-Id: <1045159485.28494.47.camel@plars>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-EhMdcDV4AD4bdQYBSvHQ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-02-13 at 11:11, John Bradford wrote:
> > > Nothing stops people from LTPtesting the -bk nightlies.
> > > Sure, they won't catch the last-minute-torvalds-breaks-the-compile
> > > type bugs, but for the most part it should be useful enough info.
> > Already been doing that for a long time now.  How about a quick note ou=
t
> > to lkml that says "The current bk is what I'm going to release at <NN
> > Time> today unless someone gives me a good reason not to."?
>=20
> Why?  That would just delay releases, and make more work for Linus.
What I just suggested would be a short 1 line note to lkml.  I know he's
very busy, but what's that, like 10 seconds?

> If a release is badly broken, another one is usually quick to follow
> it, anyway.
There's usually a lag of 30min to an hour between the last changeset and
the the one that changes the version tag anyway.  I would
hope/assume(dangerous) this is when it's beeing built and tested.  One
more script to that mix that runs a subset of ltp might add an
additional 5 min.  Alternatively, a note of intent to lkml might add a
few seconds to that delay.

If I counted timezones etc. right, here's a quick picture of the number
of minutes between the last changeset and the changeset that tagged it
with the version number:
2.5.60 52 min.
2.5.59 42 min.
2.5.58 31 min.
2.5.57 16 min.
 *** 2.5.58 was release something like 12 hours later

Is it less work to do a few minutes of extra testing, or go through
another release in the same day?

-Paul Larson

--=-EhMdcDV4AD4bdQYBSvHQ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEABECAAYFAj5L3jsACgkQbkpggQiFDqeHPwCfYzeNfBUtFpOaQpOCNkywKVEr
jxUAmgJI1/C1fyjT4bTRkanuomVcPxT+
=sVcv
-----END PGP SIGNATURE-----

--=-EhMdcDV4AD4bdQYBSvHQ--

