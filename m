Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316576AbSFUMRs>; Fri, 21 Jun 2002 08:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316578AbSFUMRr>; Fri, 21 Jun 2002 08:17:47 -0400
Received: from host213-121-105-182.in-addr.btopenworld.com ([213.121.105.182]:16515
	"EHLO mail.dark.lan") by vger.kernel.org with ESMTP
	id <S316576AbSFUMRr>; Fri, 21 Jun 2002 08:17:47 -0400
Subject: Re: [PROBLEM] sundance on d-link dfe-580tx
From: Matthew Hall <matt@ecsc.co.uk>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3D12B956.6020808@mandrakesoft.com>
References: <Pine.LNX.4.33.0206112336340.2253-100000@presario>
	<1023980246.1090.25.camel@smelly.dark.lan> 
	<3D12B956.6020808@mandrakesoft.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-3DSKW/SWsyqwBLtOa/lK"
X-Mailer: Ximian Evolution 1.0.7 
Date: 21 Jun 2002 13:17:42 +0100
Message-Id: <1024661862.2139.61.camel@smelly.dark.lan>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3DSKW/SWsyqwBLtOa/lK
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2002-06-21 at 06:27, Jeff Garzik wrote:
> Matthew,
>=20
> This patch just arrived from D-Link.  It includes fixes specifically for=20
> DFX-580TX.  Does this fix your problem?

Yes and no,
	This version didn't work (once I back-ported it to compile on 2.4.18,
which I suppose I may have not been designed to do), but I had already
got v1.02 to compile and work properly with no problems (on a previous
post).

On a similar note, but not related to the original, has anyone used this
driver on 20 ports? I'll be looking into using the driver with 4/5 of
the dfe-580's and was wondering about scalability...?

Thanks anyway Jeff,
Matthew Hall

--=20
Matthew Hall -- matt@ecsc.co.uk -- http://people.ecsc.co.uk/~matt/
Sig: Contrary to popular opinion, the plural of 'anecdote' is not
'fact'.=20

--=-3DSKW/SWsyqwBLtOa/lK
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA9Exlmw5xT5S6r89URAhUmAJ99hsfhz8ijRUakjGgtfAlcEkPzPgCfWe7e
anlguMqSk1Mu9NQJsRflHlE=
=Do0Y
-----END PGP SIGNATURE-----

--=-3DSKW/SWsyqwBLtOa/lK--

