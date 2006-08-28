Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932127AbWH1MP5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbWH1MP5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 08:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbWH1MP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 08:15:57 -0400
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:22728 "EHLO
	mail-in-07.arcor-online.net") by vger.kernel.org with ESMTP
	id S932127AbWH1MP4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 08:15:56 -0400
From: Prakash Punnoor <prakash@punnoor.de>
To: Andi Kleen <ak@muc.de>
Subject: Re: Linux v2.6.18-rc5
Date: Mon, 28 Aug 2006 14:15:40 +0200
User-Agent: KMail/1.9.4
Cc: Linus Torvalds <torvalds@osdl.org>, Marc Perkel <marc@perkel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACurrid@nvidia.com, len.brown@intel.com
References: <Pine.LNX.4.64.0608272122250.27779@g5.osdl.org> <200608280924.47968.prakash@punnoor.de> <20060828120540.GA69511@muc.de>
In-Reply-To: <20060828120540.GA69511@muc.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart35069246.7V3cemqVdR";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200608281415.41025.prakash@punnoor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart35069246.7V3cemqVdR
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Montag 28 August 2006 14:05 schrieb Andi Kleen:
> > At least my dmesg says nothing about hpet and thus wan't to enable the
> > quirk. It is a nforce430 (thus nf4) chipset, though. You can find my
> > bootlog here:
>
> Only NF5 is interesting in this case. On NF4 skipping the timer override
> is correct.

Well, then please explain me why it hangs on my nf430 with skipping and wor=
ks=20
normally w/o skipping?

=2D-=20
(=B0=3D                 =3D=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart35069246.7V3cemqVdR
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBE8t5txU2n/+9+t5gRAlkMAJ9kxYUWLgLVhXl8/GnLRf6DI9mZoACeI1py
tTG0ICBK5fS/XsUeFUEuf3o=
=VbOh
-----END PGP SIGNATURE-----

--nextPart35069246.7V3cemqVdR--
