Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265359AbTL0LJy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 06:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265361AbTL0LJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 06:09:54 -0500
Received: from wblv-224-192.telkomadsl.co.za ([165.165.224.192]:24463 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S265359AbTL0LJt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 06:09:49 -0500
Subject: Re: 2.6.0 sound output - wierd effects
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <3820000.1072499679@[10.10.2.4]>
References: <1080000.1072475704@[10.10.2.4]>
	 <1072479167.21020.59.camel@nosferatu.lan>  <1480000.1072479655@[10.10.2.4]>
	 <1072480660.21020.64.camel@nosferatu.lan>  <1640000.1072481061@[10.10.2.4]>
	 <1072482611.21020.71.camel@nosferatu.lan>  <2060000.1072483186@[10.10.2.4]>
	 <1072486379.12308.33.camel@nosferatu.lan>  <3820000.1072499679@[10.10.2.4]>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-o5CvkXVjuSppxai46JKV"
Message-Id: <1072523532.12308.55.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 27 Dec 2003 13:12:12 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-o5CvkXVjuSppxai46JKV
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2003-12-27 at 06:34, Martin J. Bligh wrote:
> >> > If you right click on xmms, and then select options->preferences, on=
 the
> >> > first page to the bottom there should be output plugin.  If you cann=
ot
> >> > select alsa, see if there is a xmms-alsa or libxmms-alsa plugin.  So=
rry,
> >> > I do not know Debian that well.
> >>=20
> >> Thanks, it was on OSS - there's no ALSA selection, nor can I find one.
> >> There's probably one in unstable somewhere, but ... see below.
> >=20
> > Btw, compile xmms yourself - should have alsa then =3D)  Not sure if
> > it will if you build with apt-get from source, or when they started
> > to ship the alsa module with xmms source - think it was not so long
> > ago.  Does with 1.2.8 though:
>=20
> Oh, I understand I could work around the problem in userspace, but that's=
=20
> not the point - something broke in the kernel, presumably OSS emulation.
> test2 works, test3 doesn't.=20
>=20

It might be that there always was a problem in userspace ... Like I said
in another mail - its working here now.  Also, _did_ you try something
else than xmms ... it may be an xmms issue, and not a alsa one ... ?


--=20
Martin Schlemmer

--=-o5CvkXVjuSppxai46JKV
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/7WkMqburzKaJYLYRAkoWAJ9YxS9+/W9qhJerf8Y6ZEp1bOgUVACgmaeg
nlYCKdw09NtMcB2QJ9mP/Kw=
=swb1
-----END PGP SIGNATURE-----

--=-o5CvkXVjuSppxai46JKV--

