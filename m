Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262129AbSJFTFq>; Sun, 6 Oct 2002 15:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262133AbSJFTFq>; Sun, 6 Oct 2002 15:05:46 -0400
Received: from grendel.firewall.com ([66.28.56.41]:41657 "EHLO
	grendel.firewall.com") by vger.kernel.org with ESMTP
	id <S262129AbSJFTFo>; Sun, 6 Oct 2002 15:05:44 -0400
Date: Sun, 6 Oct 2002 21:11:13 +0200
From: Marek Habersack <grendel@debian.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Larry McVoy <lm@bitmover.com>, "David S. Miller" <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: BK MetaData License Problem?
Message-ID: <20021006191113.GA4151@thanes.org>
References: <3DA02F30.8040904@colorfullife.com> <Pine.LNX.4.44.0210061452400.6237-100000@localhost.localdomain> <20021006154806.GA2524@thanes.org> <3DA0642A.1070706@colorfullife.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
In-Reply-To: <3DA0642A.1070706@colorfullife.com>
User-Agent: Mutt/1.4i
Organization: I just...
X-GPG-Fingerprint: 0F0B 21EE 7145 AA2A 3BF6  6D29 AB7F 74F4 621F E6EA
X-message-flag: Outlook - A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 06, 2002 at 06:26:18PM +0200, Manfred Spraul scribbled:
[snip]=20
> Marek Habersack wrote:
> >
> >Perhaps I am being silly at the moment, but wouldn't it suffice in this=
=20
> >case
> >to put a statement in your commit message (I believe it can be automated)
> >stating that this message and the comitted data are licensed under the G=
PL?
> >
>=20
> For example.
> Or a sentence in the Licensing file, or whatever.("If you want to=20
> contribute to the development at www.kernel.org, then you must agree to=
=20
> the following conditions: You name will be used, your commit text will=20
> be used, your mail address will be published etc." No GPL conflict, you
> are free to fork)
I don't think that would suffice in this case. The problem is not in your or
anybody else's consent to the terms of GPL, but that the BK license doesn't
make it clear (as I understand) as to what is the legal status of the
metadata - i.e. what's the license that pertains to it. Also, this is not
BitMover's problem actually - thus the user, developer, would have to take
care to make a clear statement as to what the changelog license is. Or,
perhaps, BitMover could add to the license that the any software (i.e.
source code, documentation, log messages etc.) are accepted under the same
license as the, say, whole repository for the software unless otherwise
stated. Then only one file in the repository would suffice to make the
situation clear - it might be even done in a way that the bk tools display
the contents of this file (let's call it a "banner") once per "session" (by
default, of course) - to ascertain that anybody using the repository will
(or may) see the contents of the file. Maybe I'm rambling :), but that looks
like a sane solution to me (not being the BK user and not even liking it, I
don't know whether such a "motd" file is possible).

regards,

marek

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9oIrRq3909GIf5uoRAh1kAJ9YpR9KeAlvRytEPLApZwy+o916YACeNAF0
OYUk1MaAdOp2E/h5QUanB4E=
=FoXM
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
