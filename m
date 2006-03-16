Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752221AbWCPVVQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752221AbWCPVVQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 16:21:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752194AbWCPVVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 16:21:16 -0500
Received: from hs-grafik.net ([80.237.205.72]:59913 "EHLO hs-grafik.net")
	by vger.kernel.org with ESMTP id S1751456AbWCPVVQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 16:21:16 -0500
From: Alexander Gran <alex@zodiac.dnsalias.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: Kernel Bug while trying to mount nfs share
Date: Thu, 16 Mar 2006 22:20:55 +0100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, Linux-Kernel <linux-kernel@vger.kernel.org>
References: <200603151244.34159@zodiac.zodiac.dnsalias.org> <Pine.LNX.4.61.0603162133100.11776@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0603162133100.11776@yvahk01.tjqt.qr>
X-Face: ){635DT*1Z+Z}$~Bf[[i"X:f2i+:Za[:Q0<UzyJPoAm(;y"@=?utf-8?q?LwMhWM4=5D=60x1bDaQDpet=3B=3Be=0A=09N=5CBIb8o=5BF!fdHrI-=7E=24?=
 =?utf-8?q?ctS=3F!?=,U+0}](xD}_b]awZrK=>753Wk;RwhCU`Bt(I^/Jxl~5zIH<
 =?utf-8?q?=0A=09XplI=3A9GKEcr/JPqzW=3BR=5FqDQe*=23CE=7E70=3Bj=25Hg8CNh*4?=<
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart9447685.0QpsREeJJ5";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200603162220.59240@zodiac.zodiac.dnsalias.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart9447685.0QpsREeJJ5
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Donnerstag, 16. M=E4rz 2006 21:35 schrieb Jan Engelhardt:
> >127MB HIGHMEM available.
> >896MB LOWMEM available.
>
> BTW, you could try ot VMSPLIT_3G_OPT.

Which works ;) BTW: Why do I need to recompile the complete kernel for that=
=20
option, and isn't there any negative impact (The menuconfig help doesn't=20
mention anything...)

regards
Alex

=2D-=20
Encrypted Mails welcome.
PGP-Key at http://zodiac.dnsalias.org/misc/pgpkey.asc | Key-ID: 0x6D7DD291

--nextPart9447685.0QpsREeJJ5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEGda7/aHb+2190pERAusEAJ4pi8b2maQV36SpzG3VBQaKSKCA1wCffbsW
fDptvlcHl+EFVv2/UeaFVqA=
=xqRo
-----END PGP SIGNATURE-----

--nextPart9447685.0QpsREeJJ5--
