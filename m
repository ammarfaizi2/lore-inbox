Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291203AbSBLVQd>; Tue, 12 Feb 2002 16:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291193AbSBLVQU>; Tue, 12 Feb 2002 16:16:20 -0500
Received: from mx02.qsc.de ([213.148.130.14]:3018 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id <S291194AbSBLVPq>;
	Tue, 12 Feb 2002 16:15:46 -0500
Subject: Re: pci_pool reap?
From: Daniel Stodden <stodden@in.tum.de>
To: =?ISO-8859-1?Q?G=E9rard?= Roudier <groudier@free.fr>
Cc: "David S. Miller" <davem@redhat.com>, alan@lxorguk.ukuu.org.uk,
        zaitcev@redhat.com, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020211220922.I1867-100000@gerard>
In-Reply-To: <20020211220922.I1867-100000@gerard>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-N1kHzCJJtRUsb+QJtCVV"
X-Mailer: Evolution/1.0.2 
Date: 12 Feb 2002 22:14:28 +0100
Message-Id: <1013548499.2240.291.camel@bitch>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-N1kHzCJJtRUsb+QJtCVV
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Mon, 2002-02-11 at 22:10, G=E9rard Roudier wrote:
>=20
> So, everything is ok. :-)

hey,

mio nada great hacker von hardware. just the guy who wants to allocate
coherent buffers into shrinking pci pools, preferably at interrupts.

since everybody seems to come up something like "well, most systems.."
and "but some arch.." i thought it might be actually of interest to look
it up, no?

<:)

dns

> > 		[1]	ok			ok

> > 		[1]	ok			ok

> > 		[1]	ok			ok

> > 		[1]	ok			ok

> >   stm:		[1]	ok			ok

> >   dc:		[3]	ok			ok

> >   ip32:		[1]	ok			ok
> >   ip27:		[1]	ok			ok

> > 		[1]	GFP_KERNEL		ok

> > 		[2]	ok			ok

> > arm:		[4]	BUG()/GFP_KERNEL	BUG()

> > 		[2]	ok			ok

> > ia64:		[5]	ok?			ok?

--=20
___________________________________________________________________________
 mailto:stodden@in.tum.de

And don't EVER make the mistake that you can design something better
than what you get from ruthless massively parallel trial-and-error
with a feedback cycle.
						- Linus Torvalds

--=-N1kHzCJJtRUsb+QJtCVV
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8aYW0SPSplX5M5nQRAhagAJ9nRo/LOV7h24Z5M28koI/gBNmLKQCeL9W9
H83zjqJIW3aI4E81W/o3KE4=
=pjlE
-----END PGP SIGNATURE-----

--=-N1kHzCJJtRUsb+QJtCVV--

