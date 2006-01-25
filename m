Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751165AbWAYNsc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbWAYNsc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 08:48:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbWAYNsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 08:48:32 -0500
Received: from hs-grafik.net ([80.237.205.72]:29452 "EHLO hs-grafik.net")
	by vger.kernel.org with ESMTP id S1751166AbWAYNsb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 08:48:31 -0500
From: Alexander Gran <alex@zodiac.dnsalias.org>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1-mm3
Date: Wed, 25 Jan 2006 14:48:10 +0100
User-Agent: KMail/1.9.1
X-Face: ){635DT*1Z+Z}$~Bf[[i"X:f2i+:Za[:Q0<UzyJPoAm(;y"@=?iso-8859-15?q?LwMhWM4=5D=60x1bDaQDpet=3B=3Be=0A=09N=5CBIb8o=5BF!fdHrI-?=
 =?iso-8859-15?q?=7E=24ctS=3F!?=,U+0}](xD}_b]awZrK=>753Wk;RwhCU`Bt(I^/Jxl~5zIH<
 =?iso-8859-15?q?=0A=09XplI=3A9GKEcr/JPqzW=3BR=5FqDQe*=23CE=7E70=3Bj=25Hg8?=
 =?iso-8859-15?q?CNh*4?=<
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1212836.G55SLmaOyc";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200601251448.20664@zodiac.zodiac.dnsalias.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1212836.G55SLmaOyc
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

mm3 is basically running ok, however it has one problem (that ocurs in mm2,=
=20
too):
My Netbeans (java-ide) debugger is to slow. It takes some ms (up to 1000 I'=
d=20
think) to step over one line, in 13-rc2-mm1 I cannot realize a delay at all.
Any Idea how to profile the kernel/my system to get an Idea. Everything els=
e=20
(C, C++, java apps..) are running fine.

regards
Alex
=2D-=20
Encrypted Mails welcome.
PGP-Key at http://zodiac.dnsalias.org/misc/pgpkey.asc | Key-ID: 0x6D7DD291

--nextPart1212836.G55SLmaOyc
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBD14Gk/aHb+2190pERAoQIAJoCUWcrl9rsfBYMJaxUIeECCORDdgCfWrpm
V7MDyjYJdH5f5xRIOrm8CKU=
=oNdA
-----END PGP SIGNATURE-----

--nextPart1212836.G55SLmaOyc--
