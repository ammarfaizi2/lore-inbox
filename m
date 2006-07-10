Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161311AbWGJDIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161311AbWGJDIg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 23:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161313AbWGJDIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 23:08:36 -0400
Received: from mail08.syd.optusnet.com.au ([211.29.132.189]:25271 "EHLO
	mail08.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1161311AbWGJDIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 23:08:36 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-rc1
Date: Mon, 10 Jul 2006 13:08:23 +1000
User-Agent: KMail/1.9.3
Cc: torvalds@osdl.org, ck list <ck@vds.kolivas.org>,
       Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1349173.ThWvuiNgdz";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200607101308.26291.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1349173.ThWvuiNgdz
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I see the merge window closed and swap prefetch got bypassed again. I'd lik=
e=20
to believe it was an oversight but far more likely that Andrew remains=20
undecided about whether it should go in or not.

No bug reports have come from it in 6 months, the code has remained unchang=
ed=20
for 3 months, it is as unobtrusive as a driver that is not compiled in=20
when !CONFIGed and there are numerous reports from satisfied users (even on=
es=20
that made it to the scary grounds of lkml). The only thing that happens is=
=20
Nick keeps threatening to review it over and over and over and....

I'm not sure what else needs to happen?

=2D-=20
=2Dck

--nextPart1349173.ThWvuiNgdz
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEscSqZUg7+tp6mRURAmQmAJ0cjvyHhkOyNTI0g/xGBpYyflZ7kQCfSF+w
xsM2c9afD4R0PErBinzwlCQ=
=RCFs
-----END PGP SIGNATURE-----

--nextPart1349173.ThWvuiNgdz--
