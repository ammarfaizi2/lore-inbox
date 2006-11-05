Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161385AbWKERif@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161385AbWKERif (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 12:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161398AbWKERie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 12:38:34 -0500
Received: from ns2.uludag.org.tr ([193.140.100.220]:23176 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S1161385AbWKERie (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 12:38:34 -0500
From: "=?utf-8?q?S=2E=C3=87a=C4=9Flar?= Onur" <caglar@pardus.org.tr>
Reply-To: caglar@pardus.org.tr
Organization: =?utf-8?q?T=C3=9CB=C4=B0TAK_/?= UEKAE
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: [Opps] Invalid opcode
Date: Sun, 5 Nov 2006 19:38:36 +0200
User-Agent: KMail/1.9.5
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       Zachary Amsden <zach@vmware.com>, Gerd Hoffmann <kraxel@suse.de>,
       john stultz <johnstul@us.ibm.com>
References: <200611051507.37196.caglar@pardus.org.tr> <200611051917.56971.caglar@pardus.org.tr> <Pine.LNX.4.61.0611051825060.15108@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0611051825060.15108@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1313251.hKjI3Mnaca";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200611051938.37005.caglar@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1313251.hKjI3Mnaca
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

05 Kas 2006 Paz 19:25 tarihinde, Jan Engelhardt =C5=9Funlar=C4=B1 yazm=C4=
=B1=C5=9Ft=C4=B1:=20
> >05 Kas 2006 Paz 18:40 tarihinde, Andi Kleen =C5=9Funlar=C4=B1 yazm=C4=B1=
=C5=9Ft=C4=B1:
> >> How do you know this?
> >
> >Just guessing, if im not wrong panics occur after SMP alternative
> > switching code done its job.
>
> Possibly compiled a kernel with instructions your processor does not
> support? Come to think of cmov...

That machine is a Intel(R) Pentium(R) 4 CPU 3.00GHz so if im not wrong cmov=
 is=20
supported on that processor

=2D-=20
S.=C3=87a=C4=9Flar Onur <caglar@pardus.org.tr>
http://cekirdek.pardus.org.tr/~caglar/

Linux is like living in a teepee. No Windows, no Gates and an Apache in hou=
se!

--nextPart1313251.hKjI3Mnaca
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFTiGcy7E6i0LKo6YRApBBAJ47cxwDNDgYROF6FidjaWHMK55y1gCggP/a
Y9Lom3Hyig4RzSrs8garXuc=
=uX2X
-----END PGP SIGNATURE-----

--nextPart1313251.hKjI3Mnaca--
