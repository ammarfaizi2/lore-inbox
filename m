Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261161AbVAaMQS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbVAaMQS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 07:16:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261163AbVAaMQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 07:16:18 -0500
Received: from 86.144.199.200.docasdoporto.com.br ([200.199.144.86]:48011 "EHLO
	shelob.localdomain") by vger.kernel.org with ESMTP id S261161AbVAaMQI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 07:16:08 -0500
Subject: Re: system calls
From: Rodrigo Ramos <rodrigo.ramos@triforsec.com.br>
To: Robert Love <rml@novell.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1107020858.11159.15.camel@localhost>
References: <1107006832.2732.35.camel@ZeroOne>
	 <1107020858.11159.15.camel@localhost>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-PK5x6TqR0tZZSnETobux"
Message-Id: <1107173059.12642.8.camel@ZeroOne>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 31 Jan 2005 09:04:19 -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-PK5x6TqR0tZZSnETobux
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Robert,

Thank you very much for your help. It really helped me.
When a say groups a mean classes like File Structure, Process Related
and etc. But I already got what I needed... Once again Thank you very
much.

Best Regards,
Rodrigo Ramos
http://www.triforsec.com.br

On Sat, 2005-01-29 at 14:47, Robert Love wrote:
> On Sat, 2005-01-29 at 10:53 -0300, Rodrigo Ramos wrote:
>=20
> > I would like to know how many groups of system calls are there at Linux
> > 2.4 and 2.6? Where can I find these informations in the Kernel?
>=20
> I don't know what you mean by groups (a nonempty set G with binary
> operation * s.t. G is associativity, there exists e in G s.t. e*a=3Da*e=
=3Da,
> and there exists i in G s.t. i*b=3Db*i=3De?).
>=20
> System calls are implemented per-architecture.  You can see the list at
> the bottom of arch/i386/kernel/entry.S.  There is about 290.
>=20
> System calls are prefixed by "sys_".  Thus, read(2) is implemented in
> the kernel as sys_read().  It, for example, can be found in
> fs/read_write.c.
>=20
> Hope this helps.
>=20
> 	Robert Love
>=20
>=20
>=20
>=20

--=-PK5x6TqR0tZZSnETobux
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBB/h7C3psv83HP4JgRAobCAJ9FL5q2N8H/qkAbyd5aCEH3thoy4wCfdaTm
GOZVSZ4rzNhtOVgYS7whjcM=
=wWmu
-----END PGP SIGNATURE-----

--=-PK5x6TqR0tZZSnETobux--

