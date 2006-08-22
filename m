Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751349AbWHVIOV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbWHVIOV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 04:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbWHVIOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 04:14:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:11703 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751349AbWHVIOT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 04:14:19 -0400
X-Authenticated: #815327
From: Malte =?iso-8859-1?q?Schr=F6der?= <MalteSch@gmx.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: reiserfs on-demand bitmap loading, what is the state?
Date: Tue, 22 Aug 2006 10:14:17 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <200608161758.41935.MalteSch@gmx.de> <20060816152139.0752f406.akpm@osdl.org>
In-Reply-To: <20060816152139.0752f406.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1311121.TrqGbCHAvx";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200608221014.18055.MalteSch@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1311121.TrqGbCHAvx
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 17 August 2006 00:21, Andrew Morton wrote:
> On Wed, 16 Aug 2006 17:58:38 +0200
> > Maybe there are tests I could run, the data on that box is easily
> > recoverable ...
>
> Yup, please run tests - anything and everything.

I did some benchmarking and other stuff (creating files, moving files aroun=
d=20
and stuff like this) to try to stress the fs a bit and simply put it to my=
=20
everyday usage. Nothing unusual showed up.

>
> Be sure to run reiserfsck before the testing to make sure the fs is clean,
> then run it again at the end of testing, see if anything ended up out of
> place.

I did.

=2D-=20
=2D--------------------------------------
Malte Schr=F6der
MalteSch@gmx.de
ICQ# 68121508
=2D--------------------------------------


--nextPart1311121.TrqGbCHAvx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBE6rza4q3E2oMjYtURAqkRAJ9onnsziztNN5bbTVhVC4/JAUIrCgCgr2bX
eBMslsMJJ+dhz43D8b+xz9Q=
=nE+1
-----END PGP SIGNATURE-----

--nextPart1311121.TrqGbCHAvx--
