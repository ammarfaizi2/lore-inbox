Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263228AbTLUO45 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 09:56:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263221AbTLUO45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 09:56:57 -0500
Received: from node-d-1fcf.a2000.nl ([62.195.31.207]:642 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S262859AbTLUO4z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 09:56:55 -0500
Subject: Re: [OT] use of patented algorithms in the kernel ok or not?
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: James Morris <jmorris@redhat.com>
Cc: Jamie Lokier <jamie@shareable.org>,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Xine.LNX.4.44.0312210833030.3044-100000@thoron.boston.redhat.com>
References: <Xine.LNX.4.44.0312210833030.3044-100000@thoron.boston.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-XJIKwb3CTw9NpBQYgbav"
Organization: Red Hat, Inc.
Message-Id: <1072018574.5225.5.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sun, 21 Dec 2003 15:56:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-XJIKwb3CTw9NpBQYgbav
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> > I expect this was said in jest, but it would be delightful to see this
> > done for real.  To the best of my knowlege it's uncharted territory,
> > so perhaps what you suggest _would_ be upheld in a court of law as
> > permissible?
> >=20
>=20
> This approach would turn Linux into proprietary software.

how so?
How is adding speed improvements to the code that may not be allowed in
ONE country make linux proprietary? We can't just rip out each and every
feature that ANY goverment or country in the world declares illegal/not
allowed to be used. CONFIG_USA and the like only provide a hint/helper
for those who want to use it in geographies where certain restrictions
are imposed by law on what software is allowed to do (without paying
third parties that is).  Now of course it's a problem if the kernel
wouldn't function at all with CONFIG_USA is set (although perfectly ok
within the gpl afaics), but for additional performance improvements ?

--=-XJIKwb3CTw9NpBQYgbav
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/5bSOxULwo51rQBIRAng2AJ46qfy153E6HBlhB2oggdtwCupctwCePxOX
9OCg4n9PFiXbJDv0rcEn38Q=
=mosH
-----END PGP SIGNATURE-----

--=-XJIKwb3CTw9NpBQYgbav--
