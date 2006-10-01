Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751226AbWJAQLm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbWJAQLm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 12:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbWJAQLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 12:11:42 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:15818 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S1751226AbWJAQLl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 12:11:41 -0400
From: "=?utf-8?q?S=2E=C3=87a=C4=9Flar?= Onur" <caglar@pardus.org.tr>
Reply-To: caglar@pardus.org.tr
Organization: =?utf-8?q?T=C3=9CB=C4=B0TAK_/?= UEKAE
To: Andi Kleen <ak@muc.de>
Subject: Re: [Ops] 2.6.18
Date: Sun, 1 Oct 2006 19:11:46 +0300
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>
References: <200610010332.52509.caglar@pardus.org.tr> <20061001103442.GA94076@muc.de>
In-Reply-To: <20061001103442.GA94076@muc.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart11718183.TxQp1QO4S8";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200610011911.47131.caglar@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart11718183.TxQp1QO4S8
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

01 Eki 2006 Paz 13:34 tarihinde, Andi Kleen =C5=9Funlar=C4=B1 yazm=C4=B1=C5=
=9Ft=C4=B1:=20
> On Sun, Oct 01, 2006 at 03:32:49AM +0300, S.??a??lar Onur wrote:
> The first thing when you get lots of weird oopses is to save your .config,
> do a make distclean and try again. Sometimes kernels get miscompiled.

I'm sure this is not miscompiled cause currently its used by lots of Pardus=
=20
alpha testers but none of them except some of them have problems. That nast=
y=20
lockup occurs on one of our buildfarm machines and this opps in vmware test=
=20
installations.

> Also your oopses do not fit completely on the screen. Best you enable
> CONFIG_VIDEO_SELECT and boot with vga=3D0x0f07
> (if that doesn't work vga=3Dask and select the smallest resolution)

I'll enable and report back.

Cheers
=2D-=20
S.=C3=87a=C4=9Flar Onur <caglar@pardus.org.tr>
http://cekirdek.pardus.org.tr/~caglar/

Linux is like living in a teepee. No Windows, no Gates and an Apache in hou=
se!

--nextPart11718183.TxQp1QO4S8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFH+jDy7E6i0LKo6YRAt2xAJ4tBhI8u4JFfypdv/a8Fl298wzHcACfQL5R
q4W84E1PIevJRZ1Kn0oS23w=
=UQuA
-----END PGP SIGNATURE-----

--nextPart11718183.TxQp1QO4S8--
