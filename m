Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261660AbSKYQ46>; Mon, 25 Nov 2002 11:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261645AbSKYQ46>; Mon, 25 Nov 2002 11:56:58 -0500
Received: from host217-36-81-41.in-addr.btopenworld.com ([217.36.81.41]:30665
	"EHLO mail.dark.lan") by vger.kernel.org with ESMTP
	id <S261663AbSKYQ4x>; Mon, 25 Nov 2002 11:56:53 -0500
Subject: Re: [PROBLEM] D-Link DFE-580TX: Only 3 Ports working
From: Gianni Tedesco <gianni@ecsc.co.uk>
To: Richard Mueller <mueller@teamix.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <140282249663.20021125161149@teamix.net>
References: <140282249663.20021125161149@teamix.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-SeB18f+XZO++PLo+yrQh"
Organization: 
Message-Id: <1038243830.22885.8.camel@lemsip>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.1.99 (Preview Release)
Date: 25 Nov 2002 17:03:51 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-SeB18f+XZO++PLo+yrQh
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2002-11-25 at 15:11, Richard Mueller wrote:
> Hello kernel-developers (esp. Donald ;) )
>=20
> I am experiencing very strange problems with the
> "D-Link DFE-580TX 4 port Server Adapter" in our enviroment.
>=20
> The kernel can only use the first three Ports. The forth Port
> is detected but reports some problems with the MII-Transciever.

Just for the record, I am using this card (infact 6 of them in one
machine, totalling 24 interfaces). All interfaces appear to work just
fine.

I'm using v1.09 of the driver though. Have you tried the latest one from
http://www.scyld.com/network/sundance.html?

HTH

--=20
// Gianni Tedesco (gianni at ecsc dot co dot uk)
lynx --source www.scaramanga.co.uk/gianni-at-ecsc.asc | gpg --import
8646BE7D: 6D9F 2287 870E A2C9 8F60 3A3C 91B5 7669 8646 BE7D

--=-SeB18f+XZO++PLo+yrQh
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA94lf2kbV2aYZGvn0RAm2nAJ0Xegl0VS2KAAYC8cnVTrGn0DMHJQCfapUm
yLreZPDXytHGHn0HTD8qKxs=
=psu9
-----END PGP SIGNATURE-----

--=-SeB18f+XZO++PLo+yrQh--

