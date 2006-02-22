Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030217AbWBVAkp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030217AbWBVAkp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 19:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030222AbWBVAkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 19:40:45 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:29149 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1030217AbWBVAko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 19:40:44 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: 2.6.16-rc4 libata + AHCI patched for suspend fails on ICH6
Date: Wed, 22 Feb 2006 10:37:45 +1000
User-Agent: KMail/1.9.1
Cc: Jens Axboe <axboe@suse.de>, Ariel Garcia <garcia@iwr.fzk.de>,
       linux-kernel@vger.kernel.org
References: <200602191958.38219.garcia@iwr.fzk.de> <20060219191859.GJ8852@suse.de> <Pine.LNX.4.58.0602210903260.8603@shark.he.net>
In-Reply-To: <Pine.LNX.4.58.0602210903260.8603@shark.he.net>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5179713.3D74ErX05X";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602221037.49604.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart5179713.3D74ErX05X
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Randy et al.

On Wednesday 22 February 2006 03:04, Randy.Dunlap wrote:
> These patches (for 2.6.16-rc3) are at
> http://www.xenotime.net/linux/SATA/2.6.16-rc3/libata-rollup-2616-rc3.patch

Randy, do you mind if I start including this in the suspend2 patch? I'm=20
starting to see more and more people who could probably use this.

Regards,

Nigel

--nextPart5179713.3D74ErX05X
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD+7JdN0y+n1M3mo0RAkEgAKCPigH6G/6Yt7TO28MwJtt2uhaqTACgmWss
dMFB1BMaXAmoW/hKqy6PyPA=
=QEEk
-----END PGP SIGNATURE-----

--nextPart5179713.3D74ErX05X--
