Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265274AbTLZXsM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 18:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265275AbTLZXrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 18:47:52 -0500
Received: from wblv-224-192.telkomadsl.co.za ([165.165.224.192]:29318 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S265274AbTLZXrt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 18:47:49 -0500
Subject: Re: 2.6.0 sound output - wierd effects
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <1640000.1072481061@[10.10.2.4]>
References: <1080000.1072475704@[10.10.2.4]>
	 <1072479167.21020.59.camel@nosferatu.lan>  <1480000.1072479655@[10.10.2.4]>
	 <1072480660.21020.64.camel@nosferatu.lan>  <1640000.1072481061@[10.10.2.4]>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-vnaugdUgr/TpJ39iSd3m"
Message-Id: <1072482611.21020.71.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 27 Dec 2003 01:50:12 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-vnaugdUgr/TpJ39iSd3m
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2003-12-27 at 01:24, Martin J. Bligh wrote:
> > Over here the your main one if not using oss emu is alsa-lib  I used
> > 0.9.8 for most of the time, but latest 1.0_rc[12] works as well.
>=20
> Debian doesn't seem to have an alsa-lib exactly.
>=20

Should provide /usr/lib/libasound.so.2.0.0 (version may differ).

> >  Also, does xmms use oss or alsa as output
> > driver - switching between the two may or may not improve things?
>=20
> Errm. No idea which it uses, nor can I see anything in it that switches ;=
-)
>=20

If you right click on xmms, and then select options->preferences, on the
first page to the bottom there should be output plugin.  If you cannot
select alsa, see if there is a xmms-alsa or libxmms-alsa plugin.  Sorry,
I do not know Debian that well.

Basically as sombody else noted - it might be with the OSS emulation,
so we want to use native alsa support with xmms ...


--=20
Martin Schlemmer

--=-vnaugdUgr/TpJ39iSd3m
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/7MkzqburzKaJYLYRAqtHAKCcS5JiIel5Gfl9rmd7Xp0cwgPM+ACdHNdM
iijFo/Cg60VctP0NdXgx684=
=t0JI
-----END PGP SIGNATURE-----

--=-vnaugdUgr/TpJ39iSd3m--

