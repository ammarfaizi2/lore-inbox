Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265935AbSKBL0q>; Sat, 2 Nov 2002 06:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265936AbSKBL0q>; Sat, 2 Nov 2002 06:26:46 -0500
Received: from B53c2.pppool.de ([213.7.83.194]:64399 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id <S265935AbSKBL0p>; Sat, 2 Nov 2002 06:26:45 -0500
Subject: Re: IRQ Routing Conflict
From: Daniel Egger <degger@fhm.edu>
To: Heinz Diehl <hd@cavy.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20021101223645.GA216@chiara.cavy.de>
References: <20021101223645.GA216@chiara.cavy.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-VpgNnR8pPeFxrF8jviQq"
X-Mailer: Ximian Evolution 1.0.8 
Date: 02 Nov 2002 00:42:34 +0100
Message-Id: <1036194155.14932.17.camel@sonja.de.interearth.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-VpgNnR8pPeFxrF8jviQq
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Fre, 2002-11-01 um 23.36 schrieb Heinz Diehl:

> [....]
> 8139too Fast Ethernet driver 0.9.26
> PCI: Found IRQ 11 for device 00:11.0
> IRQ routing conflict for 00:11.0, have irq 10, want irq 11
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  =20

> Regardless of which PCI slot the card uses, the problem stays the same.
> I searched the net and found many people having the same trouble, but not=
 a
> single solution for it.

Now that you mentioned it: Just a few hours ago I popped in a soundcard
into one of my machines:
Nov  1 16:10:20 nicole kernel: solo1: version v0.19 time 11:19:52 Apr 14 20=
02
Nov  1 16:10:20 nicole kernel: PCI: Found IRQ 10 for device 00:13.0
Nov  1 16:10:20 nicole kernel: IRQ routing conflict for 00:13.0, have irq 3=
, want irq 10

This is also an Apollo/MVP3 chipset. Other than that the soundcard seems
to work fine. I don't see this with any other card BTW.

--=20
Servus,
       Daniel

--=-VpgNnR8pPeFxrF8jviQq
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA9wxFqchlzsq9KoIYRAn0dAJsH70LdBh46TXLpWDCHLwq3xvRXuwCfb+IT
6nRRjArm8KbGdTcm0EezXIQ=
=GTa2
-----END PGP SIGNATURE-----

--=-VpgNnR8pPeFxrF8jviQq--

