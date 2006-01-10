Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751130AbWAJAaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbWAJAaW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 19:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932129AbWAJAaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 19:30:22 -0500
Received: from hs-grafik.net ([80.237.205.72]:46092 "EHLO hs-grafik.net")
	by vger.kernel.org with ESMTP id S1751130AbWAJAaV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 19:30:21 -0500
From: Alexander Gran <alex@zodiac.dnsalias.org>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-mm2
Date: Tue, 10 Jan 2006 01:30:11 +0100
User-Agent: KMail/1.8.3
References: <20060107052221.61d0b600.akpm@osdl.org> <200601080139.34774@zodiac.zodiac.dnsalias.org> <20060107175056.3d7a2895.akpm@osdl.org>
In-Reply-To: <20060107175056.3d7a2895.akpm@osdl.org>
X-Face: ){635DT*1Z+Z}$~Bf[[i"X:f2i+:Za[:Q0<UzyJPoAm(;y"@=?iso-8859-15?q?LwMhWM4=5D=60x1bDaQDpet=3B=3Be=0A=09N=5CBIb8o=5BF!fdHrI-?=
 =?iso-8859-15?q?=7E=24ctS=3F!?=,U+0}](xD}_b]awZrK=>753Wk;RwhCU`Bt(I^/Jxl~5zIH<
 =?iso-8859-15?q?=0A=09XplI=3A9GKEcr/JPqzW=3BR=5FqDQe*=23CE=7E70=3Bj=25Hg8?=
 =?iso-8859-15?q?CNh*4?=<
MIME-Version: 1.0
Message-Id: <200601100130.12227@zodiac.zodiac.dnsalias.org>
Content-Type: multipart/signed;
  boundary="nextPart1175537.ZXvSUS3DB2";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1175537.ZXvSUS3DB2
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Sonntag, 8. Januar 2006 02:50 schrieben Sie:
> Can you try removing EDAC from .config?

Just did.

> I doubt if the cause is EDAC really.  If you could investigate a bit
> further it'd help.  mtrr?  Run top?  Generate a kernel profile?  Is it ju=
st
> X being sluggish?  (DRM/AGP?) etc.


EDAC errors are gone. System isn't sluggish ;)
However one new erro:
serial8250: too much work for irq3
serial8250: too much work for irq3

regards
Alex

=2D-=20
Encrypted Mails welcome.
PGP-Key at http://zodiac.dnsalias.org/misc/pgpkey.asc | Key-ID: 0x6D7DD291

--nextPart1175537.ZXvSUS3DB2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDwwAU/aHb+2190pERAkfaAJ96t3LCtAlcukJ9VCuuQH0LM4C2OQCbBpOk
wZYbPw+qLg0jcxvWZMHhQ8Y=
=nEFJ
-----END PGP SIGNATURE-----

--nextPart1175537.ZXvSUS3DB2--
