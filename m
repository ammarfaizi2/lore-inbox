Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751349AbWCWRcd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbWCWRcd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 12:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbWCWRcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 12:32:33 -0500
Received: from hs-grafik.net ([80.237.205.72]:49158 "EHLO hs-grafik.net")
	by vger.kernel.org with ESMTP id S1751349AbWCWRcc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 12:32:32 -0500
From: Alexander Gran <alex@zodiac.dnsalias.org>
To: "Vladimir V. Saveliev" <vs@namesys.com>
Subject: Re: 2.6.16-rc6-mm2: reiser4 BUG when unmounting fs
Date: Thu, 23 Mar 2006 18:32:14 +0100
User-Agent: KMail/1.9.1
Cc: Laurent Riffard <laurent.riffard@free.fr>, Andrew Morton <akpm@osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       reiserfs-list@namesys.com
References: <20060318044056.350a2931.akpm@osdl.org> <44206428.1080005@free.fr> <1143013406.6245.46.camel@tribesman.namesys.com>
In-Reply-To: <1143013406.6245.46.camel@tribesman.namesys.com>
X-Face: ){635DT*1Z+Z}$~Bf[[i"X:f2i+:Za[:Q0<UzyJPoAm(;y"@=?utf-8?q?LwMhWM4=5D=60x1bDaQDpet=3B=3Be=0A=09N=5CBIb8o=5BF!fdHrI-=7E=24?=
 =?utf-8?q?ctS=3F!?=,U+0}](xD}_b]awZrK=>753Wk;RwhCU`Bt(I^/Jxl~5zIH<
 =?utf-8?q?=0A=09XplI=3A9GKEcr/JPqzW=3BR=5FqDQe*=23CE=7E70=3Bj=25Hg8CNh*4?=<
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5040566.CfzM4MkytI";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200603231832.21706@zodiac.zodiac.dnsalias.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart5040566.CfzM4MkytI
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Mittwoch, 22. M=E4rz 2006 08:43 schrieb Vladimir V. Saveliev:
> The attached patch fixes the problem.

confirmed, works in 2.6.16-mm1.

regards
Alex

=2D-=20
Encrypted Mails welcome.
PGP-Key at http://zodiac.dnsalias.org/misc/pgpkey.asc | Key-ID: 0x6D7DD291

--nextPart5040566.CfzM4MkytI
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEItul/aHb+2190pERAsVnAJ495P2/pmSqdqsemDJSDOMvJ9optQCfdQze
2j8Strj/UpKrbU/r3nbNqeo=
=PGPy
-----END PGP SIGNATURE-----

--nextPart5040566.CfzM4MkytI--
