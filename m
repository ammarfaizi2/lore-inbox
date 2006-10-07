Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932270AbWJGPsQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbWJGPsQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 11:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932275AbWJGPsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 11:48:16 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:35514 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S932270AbWJGPsP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 11:48:15 -0400
From: "=?utf-8?q?S=2E=C3=87a=C4=9Flar?= Onur" <caglar@pardus.org.tr>
Reply-To: caglar@pardus.org.tr
Organization: =?utf-8?q?T=C3=9CB=C4=B0TAK_/?= UEKAE
To: john stultz <johnstul@us.ibm.com>
Subject: Re: 2.6.18 Nasty Lockup
Date: Sat, 7 Oct 2006 18:48:25 +0300
User-Agent: KMail/1.9.5
Cc: Greg Schafer <gschafer@zip.com.au>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@muc.de>
References: <20060926123640.GA7826@tigers.local> <200609291149.52443.caglar@pardus.org.tr> <1160175452.6140.45.camel@localhost.localdomain>
In-Reply-To: <1160175452.6140.45.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1362412.6mqpSzr7u5";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200610071848.25904.caglar@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1362412.6mqpSzr7u5
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

07 Eki 2006 Cts 01:57 tarihinde, john stultz =C5=9Funlar=C4=B1 yazm=C4=B1=
=C5=9Ft=C4=B1:=20
> Hey S.=C3=87a=C4=9Flar,
>
> 	So I just wrote up this test case that will show how skewed the TSCs
> are. I'd be interested if you could run it a few times quickly after a
> fresh boot, and then again a day or so later.
>
> See the header comment for instructions.
>
> And just a fair warning: this runs w/ SCHED_FIFO, and thus has the
> potential to hang your system (while writing it I made a few flubs and
> it hung my system). I believe I've got all of the issues fixed (tested
> on a few systems), but wanted to give you a fair warning before I
> suggest you run this.  :)

Ok ill try this on Monday, thanks!

Cheers
=2D-=20
S.=C3=87a=C4=9Flar Onur <caglar@pardus.org.tr>
http://cekirdek.pardus.org.tr/~caglar/

Linux is like living in a teepee. No Windows, no Gates and an Apache in hou=
se!

--nextPart1362412.6mqpSzr7u5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFJ8xJy7E6i0LKo6YRAnrhAJ9PX6hLS2+t+qSAH4c1LpaqwRiVSgCfVpLi
jCbpxCSIOUv3ljmC7gGHdXY=
=mxGA
-----END PGP SIGNATURE-----

--nextPart1362412.6mqpSzr7u5--
