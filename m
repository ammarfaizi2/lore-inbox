Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262673AbVA0RXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262673AbVA0RXK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 12:23:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262674AbVA0RVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 12:21:13 -0500
Received: from zlynx.org ([199.45.143.209]:52488 "EHLO 199.45.143.209")
	by vger.kernel.org with ESMTP id S262673AbVA0RTl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 12:19:41 -0500
Subject: Re: thoughts on kernel security issues
From: Zan Lynx <zlynx@acm.org>
To: Jesse Pollard <jesse@cats-chateau.net>
Cc: Bill Davidsen <davidsen@tmr.com>, linux-os <linux-os@analogic.com>,
       John Richard Moser <nigelenki@comcast.net>, dtor_core@ameritech.net,
       Linus Torvalds <torvalds@osdl.org>, Valdis.Kletnieks@vt.edu,
       Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <05012710374600.20895@tabby>
References: <Pine.LNX.3.96.1050126143205.24013A-100000@gatekeeper.tmr.com>
	 <05012710374600.20895@tabby>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-NOc6nkdXpvjonoz+seiq"
Date: Thu, 27 Jan 2005 10:18:34 -0700
Message-Id: <1106846314.15927.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-NOc6nkdXpvjonoz+seiq
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-01-27 at 10:37 -0600, Jesse Pollard wrote:
> On Wednesday 26 January 2005 13:56, Bill Davidsen wrote:
> > On Wed, 26 Jan 2005, Jesse Pollard wrote:
> > > On Tuesday 25 January 2005 15:05, linux-os wrote:
> > > > This isn't relevant at all. The Navy doesn't have any secure
> > > > systems connected to a network to which any hackers could connect.
> > > > The TDRS communications satellites provide secure channels
> > > > that are disassembled on-board. Some ATM-slot, after decryption
> > > > is fed to a LAN so the sailors can have an Internet connection
> > > > for their lap-tops. The data took the same paths, but it's
> > > > completely independent and can't get mixed up no matter how
> > > > hard a hacker tries.
> > >
> > > Obviously you didn't hear about the secure network being hit by the "=
I
> > > love you" virus.
> > >
> > > The Navy doesn't INTEND to have any secure systems connected to a net=
work
> > > to which any hackers could connect.
> >
> > What's hard about that? Matter of physical network topology, absolutely=
 no
> > physical connection, no machines with a 2nd NIC, no access to/from I'ne=
t.
> > Yes, it's a PITA, add logging to a physical printer which can't be eras=
ed
> > if you want to make your CSO happy (corporate security officer).
>=20
> And you are ASSUMING the connection was authorized. I can assure you that=
=20
> there are about 200 (more or less) connections from the secure net to the
> internet expressly for the purpose of transferring data from the internet
> to the secure net for analysis. And not ALL of these connections are=20
> authorized. Some are done via sneakernet, others by running a cable ("I n=
eed
> the data NOW... I'll just disconnect afterward..."), and are not visible
> for very long. Other connections are by picking up a system and carrying =
it
> from one connection to another (a version of sneakernet, though here it
> sometimes needs a hand cart).
>=20
> > > Unfortunately, there will ALWAYS be a path, either direct, or indirec=
t
> > > between the secure net and the internet.
> >
> > Other than letting people use secure computers after they have seen the
> > Internet, a good setup has no indirect paths.
>=20
> Ha. Hahaha...
>=20
> Reality bites.

In the reality I'm familiar with, the defense contractor's secure
projects building had one entrance, guarded by security guards who were
not cheap $10/hr guys, with strict instructions.  No computers or
computer media were allowed to leave the building except with written
authorization of a corporate officer.  The building was shielded against
Tempest attacks and verified by the NSA.  Any computer hardware or media
brought into the building for the project was physically destroyed at
the end.

Secure nets _are_ possible.
--=20
Zan Lynx <zlynx@acm.org>

--=-NOc6nkdXpvjonoz+seiq
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBB+SJqG8fHaOLTWwgRAlJFAJ0X4gnFk05Oj0oQwkf9J20PsbHsIwCgoZQz
tYX5r3RoNw/gLWsJAelDw5c=
=bON8
-----END PGP SIGNATURE-----

--=-NOc6nkdXpvjonoz+seiq--

