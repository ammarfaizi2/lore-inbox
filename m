Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbWCOR2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbWCOR2j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 12:28:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbWCOR2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 12:28:39 -0500
Received: from hs-grafik.net ([80.237.205.72]:7180 "EHLO hs-grafik.net")
	by vger.kernel.org with ESMTP id S1750702AbWCOR2j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 12:28:39 -0500
From: Alexander Gran <alex@zodiac.dnsalias.org>
To: john stultz <johnstul@us.ibm.com>
Subject: Re: 2.6.16-rc6-mm1 : Setting clocksource results in error
Date: Wed, 15 Mar 2006 18:28:31 +0100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, Linux-Kernel <linux-kernel@vger.kernel.org>
References: <200603140935.26927@zodiac.zodiac.dnsalias.org> <200603151153.18873@zodiac.zodiac.dnsalias.org> <1142442974.8797.12.camel@cog.beaverton.ibm.com>
In-Reply-To: <1142442974.8797.12.camel@cog.beaverton.ibm.com>
X-Face: ){635DT*1Z+Z}$~Bf[[i"X:f2i+:Za[:Q0<UzyJPoAm(;y"@=?utf-8?q?LwMhWM4=5D=60x1bDaQDpet=3B=3Be=0A=09N=5CBIb8o=5BF!fdHrI-=7E=24?=
 =?utf-8?q?ctS=3F!?=,U+0}](xD}_b]awZrK=>753Wk;RwhCU`Bt(I^/Jxl~5zIH<
 =?utf-8?q?=0A=09XplI=3A9GKEcr/JPqzW=3BR=5FqDQe*=23CE=7E70=3Bj=25Hg8CNh*4?=<
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3029449.Rzckpp7LHK";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200603151828.34416@zodiac.zodiac.dnsalias.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3029449.Rzckpp7LHK
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Oh sorry. Lilo got mad my automated kernel-install-script, so I was using t=
he=20
unpatched kernel again. Works as expected!

Am Mittwoch, 15. M=E4rz 2006 18:16 schrieb john stultz:
> On Wed, 2006-03-15 at 11:53 +0100, Alexander Gran wrote:
> > applied patch. Didn't work?! Same error as before..
>
> Huh. Now I'm quite confused. And using the -n option w/ echo doesn't
> change the behavior?
>
> thanks
> -john

=2D-=20
Encrypted Mails welcome.
PGP-Key at http://zodiac.dnsalias.org/misc/pgpkey.asc | Key-ID: 0x6D7DD291

--nextPart3029449.Rzckpp7LHK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEGE7C/aHb+2190pERArqVAJsEswRTxCmrb7x98cFXVxVSQS2bCwCfQQp+
RJuztx2tBgk9YOtBWx16rLw=
=p7eg
-----END PGP SIGNATURE-----

--nextPart3029449.Rzckpp7LHK--
