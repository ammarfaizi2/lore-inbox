Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267038AbTA0KTr>; Mon, 27 Jan 2003 05:19:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267042AbTA0KTr>; Mon, 27 Jan 2003 05:19:47 -0500
Received: from host213-121-111-56.in-addr.btopenworld.com ([213.121.111.56]:57293
	"EHLO mail.dark.lan") by vger.kernel.org with ESMTP
	id <S267038AbTA0KTq>; Mon, 27 Jan 2003 05:19:46 -0500
Subject: Re: memory->disk
From: Gianni Tedesco <gianni@ecsc.co.uk>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: Electroniks New <elektr_new@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20030125191747.A646@nightmaster.csn.tu-chemnitz.de>
References: <20030125190835.44069.qmail@web14711.mail.yahoo.com> 
	<20030125191747.A646@nightmaster.csn.tu-chemnitz.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-kFn6HpeqVI2HzJCbZgSx"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 27 Jan 2003 10:29:13 +0000
Message-Id: <1043663353.6978.21.camel@lemsip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-kFn6HpeqVI2HzJCbZgSx
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2003-01-25 at 18:17, Ingo Oeser wrote:
> On Sat, Jan 25, 2003 at 11:08:35AM -0800, Electroniks New wrote:
> >   How to save a process from memory onto the disk.
>=20
> Software Suspend is what you are looking for.

Or possibly process check-pointing, ala CRAK.

http://www.ncl.cs.columbia.edu/research/migrate/crak.html

--=20
// Gianni Tedesco (gianni at scaramanga dot co dot uk)
lynx --source www.scaramanga.co.uk/gianni-at-ecsc.asc | gpg --import
8646BE7D: 6D9F 2287 870E A2C9 8F60 3A3C 91B5 7669 8646 BE7D

--=-kFn6HpeqVI2HzJCbZgSx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA+NQn4kbV2aYZGvn0RAmTXAJ0efjL5n6exSiZaCxv4kdp4EbBR4wCdGrxn
BzKILL4OWrdNcRvUAUmSV2Q=
=RYcq
-----END PGP SIGNATURE-----

--=-kFn6HpeqVI2HzJCbZgSx--

