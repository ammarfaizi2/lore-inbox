Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264351AbTLZWu2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 17:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264461AbTLZWu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 17:50:28 -0500
Received: from wblv-224-192.telkomadsl.co.za ([165.165.224.192]:43141 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S264351AbTLZWu0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 17:50:26 -0500
Subject: Re: 2.6.0 sound output - wierd effects
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <1080000.1072475704@[10.10.2.4]>
References: <1080000.1072475704@[10.10.2.4]>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-7g3SUfCp2Zw5HWwOdPDN"
Message-Id: <1072479167.21020.59.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 27 Dec 2003 00:52:47 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-7g3SUfCp2Zw5HWwOdPDN
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2003-12-26 at 23:55, Martin J. Bligh wrote:
> Upgraded my home desktop to 2.6.0.=20
> Somewhere between 2.5.63 and 2.6.0, sound got screwed up - I've confirmed
> this happens on mainline, as well as -mjb.
>=20
> If I leave xmms playing (in random shuffle mode) every 2 minutes or so,
> I'll get some wierd effect for a few seconds, either static, or the track=
=20
> will mysteriously speed up or slow down. Then all is back to normal for=20
> another couple of minutes.
>=20
> Anyone else seen this, or got any clues? Else I guess I'm stuck playing
> bisection search.
>=20
> Advanced Linux Sound Architecture Driver Version 0.9.7 (Thu Sep 25 19:16:=
36 2003 UTC).
> PCI: Found IRQ 11 for device 0000:00:02.7
> intel8x0: clocking to 48000
> ALSA device list:
> #0: SiS SI7012 at 0xdc00, irq 11
>=20
> AMD Athlon(tm) XP 2100+, no power management or ACPI compiled in.
>=20

I have had this as well, around there, and started using OSS, which
worked fine (ICH5 onboard - also).  Somewhere when I tried again, it
worked fine, so this is what I am using now.  What version userland
libs/utils ?  OSS emulation?

--=20
Martin Schlemmer

--=-7g3SUfCp2Zw5HWwOdPDN
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/7Lu+qburzKaJYLYRAnPxAJ99XuJIWFmDfMJWYZTJN29Yul55QACfXUvm
OVLv+A/4RPm9jGGNnFHU+yk=
=cm7G
-----END PGP SIGNATURE-----

--=-7g3SUfCp2Zw5HWwOdPDN--

