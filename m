Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265282AbTL0AmU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 19:42:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265283AbTL0AmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 19:42:20 -0500
Received: from wblv-224-192.telkomadsl.co.za ([165.165.224.192]:12935 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S265282AbTL0AmS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 19:42:18 -0500
Subject: Re: 2.6.0 sound output - wierd effects
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <2060000.1072483186@[10.10.2.4]>
References: <1080000.1072475704@[10.10.2.4]>
	 <1072479167.21020.59.camel@nosferatu.lan>  <1480000.1072479655@[10.10.2.4]>
	 <1072480660.21020.64.camel@nosferatu.lan>  <1640000.1072481061@[10.10.2.4]>
	 <1072482611.21020.71.camel@nosferatu.lan>  <2060000.1072483186@[10.10.2.4]>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-usFORAmnKUMhPg7CPgIl"
Message-Id: <1072485880.12308.27.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 27 Dec 2003 02:44:41 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-usFORAmnKUMhPg7CPgIl
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2003-12-27 at 01:59, Martin J. Bligh wrote:

> > Basically as sombody else noted - it might be with the OSS emulation,
> > so we want to use native alsa support with xmms ...
>=20
> I'll play with it - should narrow things down. However, fundamentally,
> it used to work in 2.5.74, and is broken as of test3 ... that strongly
> implies to me there's a kernel problem. I'd rather fix OSS emulation
> if possible, and save everybody migrating to 2.6 from this pain ... ;-)
>=20

I was using esound compiled with alsa support, but I just killed it and
played with oss for some time now - seems still fine this side.

You might try to go to the preferences again, and configure oss plugin,
and up the buffer used.  On another note - did you try another player
than xmms?  Using xmms 1.2.8 here, so if Debian that far behind, it
may still be an xmms issue ...


--=20
Martin Schlemmer

--=-usFORAmnKUMhPg7CPgIl
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/7NX4qburzKaJYLYRAjZoAJ4zlJrutwYQc98aMM0NX8Jg4U3FpQCgiH67
xEkFRjtQOAnlVwDjea8trRo=
=FMd/
-----END PGP SIGNATURE-----

--=-usFORAmnKUMhPg7CPgIl--

