Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261335AbVBNNNi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbVBNNNi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 08:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261431AbVBNNNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 08:13:37 -0500
Received: from nijmegen.renzel.net ([195.243.213.130]:43204 "EHLO
	mx1.renzel.net") by vger.kernel.org with ESMTP id S261335AbVBNNNS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 08:13:18 -0500
From: Mws <mws@twisted-brains.org>
To: lm@bitmover.com, linux-kernel@vger.kernel.org
Subject: Re: [BK] upgrade will be needed
Date: Mon, 14 Feb 2005 14:13:31 +0100
User-Agent: KMail/1.7.92
References: <20050214020802.GA3047@bitmover.com>
In-Reply-To: <20050214020802.GA3047@bitmover.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart9247964.PBGD0vBhve";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200502141413.36066.mws@twisted-brains.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart9247964.PBGD0vBhve
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 14 February 2005 03:08, Larry McVoy wrote:
> This is a heads up that the BK tree for the kernel is currently at 59,000
> changesets give or take a few.  The BK that you are using uses unsigned
> shorts for the internal names of each delta which means you folks are
> about 100 days away from things no longer working.
>=20
> The good news is that the openlogging tree for the kernel has 135,000
> changesets so we've obviously long since fixed this problem.
>=20
> The bad news is that you will need to upgrade your BK binary in order
> to pass over the 64K changeset boundary.  The data is stored on disk in
> ascii so it doesn't matter if you upgrade until you hit the problem but
> sooner or later you will need to upgrade.
>=20
> We'll get the fix into bk-3.2.4 which should be out by the end of the
> month.  When we release that we'll send out notice and it would be good
> if people gave it a try and let us know if they hit issues because in a
> couple of months everyone is going to have to upgrade.
>=20
> It's possible that we'll be changing the BK license to conform more with
> our commercial license but we won't do that without running it by Linus &
> Co to make sure that it's acceptable.  One change we'd like to make there
> is to clarify the non-compete stuff.  We've had some people who have
> indicated that they believed that if they used BK they were agreeing
> that they would never work on another SCM system.  We can see how it
> is possible that people would interpret the license that way but that
> wasn't our intent.  What we would like to do is change the language to
> say that if you use BK you are agreeing that you won't work on another
> SCM for 1 year after you stop using BK.  But after that you would be
> able to hack on anything that you wanted.  That was more of what we
> had in mind in the first place but we didn't make it clear.  If you all
> thought that using BK meant you had no right to hack on SCM ever again,
> that's just not fair.  We need to protect our IP but you should have
> the right to choose to go hack SCM if that's what you (our first choice
> is that you came and worked here, we really like kernel hackers, but if
> you don't want to that's cool too).
Hi,=20

do you mean "if you use BK you are agreeing that you won't work on another
SCM for 1 year after you stop using BK." for the kernel tree and developers=
 or in general?

i think this statement is just a kind of trying the MicrosoftBeingTheOneAnd=
Only way.
it's a kind of extortion - use bk or die :/
if it is really being that way - say goodbye to bk as soon as possible.

regards
mws

--nextPart9247964.PBGD0vBhve
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCEKQAPpA+SyJsko8RAptkAJ0arKO2plUMLcEMd4KbVYD5j6+ukwCgqwUB
ndWjiMTESOSBw3dnghtw9gU=
=t76S
-----END PGP SIGNATURE-----

--nextPart9247964.PBGD0vBhve--
