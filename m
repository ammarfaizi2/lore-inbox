Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261688AbVEDVvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261688AbVEDVvW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 17:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261703AbVEDVvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 17:51:22 -0400
Received: from mail01.solnet.ch ([212.101.4.135]:38673 "EHLO mail01.solnet.ch")
	by vger.kernel.org with ESMTP id S261688AbVEDVvH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 17:51:07 -0400
From: Damir Perisa <damir.perisa@solnet.ch>
To: Cameron Harris <thecwin@gmail.com>
Subject: Re: 2.6.12-rc3-mm2 - kswapd0 keeps running
Date: Wed, 4 May 2005 23:47:09 +0200
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <20050430164303.6538f47c.akpm@osdl.org> <200505011707.35461.damir.perisa@solnet.ch> <b6d0f5fb05050412126dc4cd28@mail.gmail.com>
In-Reply-To: <b6d0f5fb05050412126dc4cd28@mail.gmail.com>
X-Face: +)fhYFmn|<pyRIlgch_);krg#jn!^z'?xy(Ur#Z6rZi)KD+_-V<Y@i>0pOVfJ4<=?iso-8859-1?q?Q1/=26/=26z=0A=093cxqRa=3B7O=5C4g=5C=7C=5DF-!H0!ew9kx1LqK/?=
 =?iso-8859-1?q?iPOv8eXi=26I7=60Pez0V0VNMAxnqRL8-30qqKK=3DxGM=0A=09pExQc=5B?=
 =?iso-8859-1?q?2=7Cl6v=23?=<iwBvEO9+h|_YS[48z%/kuD2*aT*S/$0323VCL3V9?@}jq<
 =?iso-8859-1?q?Ns6V=3A0m=27Qia=0A=09?="[#oJg[RVe}Sy/lP95E@pa[vdKzqLqn&M`exb91"`,<k`3;Vt97cLjhub0.v+]m`%|>@Z(
 =?iso-8859-1?q?=0A=09EeC/zU7=25?=@"L6mi#..8Q^M
Alanine: true
Glycine: true
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1369811.F8WAao2C4S";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200505042347.12863.damir.perisa@solnet.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1369811.F8WAao2C4S
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Le Wednesday 04 May 2005 21:12, Cameron Harris a =E9crit=A0:
> I can sort of confirm this, except on a different kernel version.
> This kswapd0 taking 100% cpu is on my 2.6.12-rc2-mm3 compiled with
> cachefs. Next time I boot into it I can check my sysrq-P and see if
> cachefs is causing it on mine...
> It tends to be after something has heavily used my hard drive.

very interesting observation. unfortunately i will be offline untill next=20
tuesday and cannot check that for my case.=20

Damir

PS
don't forget your mother ... especially on next sunday

=2D-=20
To fear love is to fear life, and those who fear life are already three
parts dead.
		-- Bertrand Russell

--nextPart1369811.F8WAao2C4S
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCeULgPABWKV6NProRAhLGAKDBWJb7lKFmiENlVU6l7JSfPXmXWACg1TDl
A7cg0HBc1JrVVaHKMm4QZQg=
=W7WH
-----END PGP SIGNATURE-----

--nextPart1369811.F8WAao2C4S--
