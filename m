Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261631AbVCVSpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbVCVSpN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 13:45:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbVCVSom
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 13:44:42 -0500
Received: from sky.skycomputers.com ([198.4.246.2]:29313 "EHLO
	sky.skycomputers.com") by vger.kernel.org with ESMTP
	id S261623AbVCVSnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 13:43:42 -0500
From: Brian Waite <waite@skycomputers.com>
To: All Linux <allinux@gmail.com>
Subject: Re: [PATCH] 2.6.12-rc1, ./drivers/base/platform.c
Date: Tue, 22 Mar 2005 13:32:09 -0500
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <cb57165a050321213210961749@mail.gmail.com>
In-Reply-To: <cb57165a050321213210961749@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1540831.fU2FZyXQmS";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200503221332.15068.waite@skycomputers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1540831.fU2FZyXQmS
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 22 March 2005 00:32, All Linux wrote:
> It causes problem, as most platform files, for example,
> arch/ppc/platforms/katana.c, still use the old name without ".". I do
Mark Greer recently produced a patch for the katana board among other PPC p=
latforms=20
to fix this breakage. I'll look for the announcement mail but I recall seei=
ng it a day or two ago.

Thanks
Brian

--nextPart1540831.fU2FZyXQmS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCQGSumxLCz0u+Ko8RAmS+AJ9yItx0O78T0+XOwNIIGM2S4Pc/KACdHM5V
uWEqXNdMQ1pLnMmKZWLh/MI=
=BlWp
-----END PGP SIGNATURE-----

--nextPart1540831.fU2FZyXQmS--
