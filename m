Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263272AbTJUTDl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 15:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263273AbTJUTDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 15:03:41 -0400
Received: from [199.45.143.209] ([199.45.143.209]:7174 "EHLO 199.45.143.209")
	by vger.kernel.org with ESMTP id S263272AbTJUTDk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 15:03:40 -0400
Subject: Re: 2.6.0-test8 and HIGMEM = segfaults and panics?
From: Zan Lynx <zlynx@acm.org>
To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20031021155337.GF2617@rdlg.net>
References: <20031021155337.GF2617@rdlg.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ybyrBF7hcRlNgoGek42t"
Organization: 
Message-Id: <1066762982.5055.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 21 Oct 2003 13:03:02 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ybyrBF7hcRlNgoGek42t
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-10-21 at 09:53, Robert L. Harris wrote:
> I'm running a dual-athalon system.  When I compiled the 2.6.0-test8 kerne=
l I
> enabled HIGHMEM for 4 Gigs as I'm at 1.5G now and planning on purchasing
> an additional 512Meg DIMM next weekend (yeah, should have with the
> 1.5Gig).
>=20
> At any rate the box comes up just fine and runs for a while but once the
> memory is in use for a few hours and seems to exceed 220+ Megs about any
> command I execute will Segfault and the kernel has panic'd twice
> (couldn't read the whole oops).

I run a dual athlon system with 2 GB, and it has never done anything
like that.

Have you run memtest86 on your system to verify it isn't a physical
memory problem?

Are you using registered RAM chips?  I seem to remember from my
motherboard documentation that registered is required to use more than 2
memory slots.
--=20
Zan Lynx <zlynx@acm.org>

--=-ybyrBF7hcRlNgoGek42t
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA/lYLmG8fHaOLTWwgRApAsAJ9WhdhdXGsQQ4ZBk5OscL/e1uSBrACgmR8T
B+zg1O85S811FPh31wxoZB0=
=BuPR
-----END PGP SIGNATURE-----

--=-ybyrBF7hcRlNgoGek42t--

