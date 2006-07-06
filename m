Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030238AbWGFMo7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030238AbWGFMo7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 08:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965192AbWGFMo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 08:44:59 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:650 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S965190AbWGFMo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 08:44:59 -0400
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Linux v2.6.18-rc1
Date: Thu, 6 Jul 2006 22:44:40 +1000
User-Agent: KMail/1.9.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.64.0607052115210.12404@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607052115210.12404@g5.osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1225820.l81EjJjihU";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200607062244.51814.ncunningham@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1225820.l81EjJjihU
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Thursday 06 July 2006 14:26, Linus Torvalds wrote:
> Ok,
>  the merge window for 2.6.18 is closed, and -rc1 is out there (git trees
> updated, the tar-ball and patches are still uploading over my pitiful DSL
> line - and as usual it may take a short while before mirroring takes
> place and distributes things across the globe).

On my amd64 based laptop, I had a failures with both suspend implementation=
s=20
(swsusp and suspend2) when I had iommu debugging on. The same config worked=
=20
fine with 2.6.17. I guess something in the delta didn't like iommu usage=20
being forced on a Turion. I'm not sure how much time I'll find for further=
=20
debugging, so I'll report it now.

Regards,

Nigel
=2D-=20
Nigel, Michelle and Alisdair Cunningham
5 Mitchell Street
Cobden 3266
Victoria, Australia

--nextPart1225820.l81EjJjihU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBErQXDN0y+n1M3mo0RAsmQAJ9zZFtVct+jP5AgycsX+3uz2CRuYgCg5X3e
0fgLqSgSacBe5gv59FvmbkE=
=wWJR
-----END PGP SIGNATURE-----

--nextPart1225820.l81EjJjihU--
