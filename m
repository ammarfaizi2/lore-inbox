Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267418AbSLLE6N>; Wed, 11 Dec 2002 23:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267419AbSLLE6N>; Wed, 11 Dec 2002 23:58:13 -0500
Received: from pimout4-ext.prodigy.net ([207.115.63.103]:27647 "EHLO
	pimout4-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S267418AbSLLE6M>; Wed, 11 Dec 2002 23:58:12 -0500
Date: Wed, 11 Dec 2002 21:03:15 -0800
From: Joshua Kwan <joshk@mspencer.net>
To: linux-kernsl@vger.kernel.org
Message-Id: <20021211210315.03f90653.joshk@mspencer.net>
In-Reply-To: <3457.210.8.93.34.1039665245.squirrel@www.csn.ul.ie>
References: <3457.210.8.93.34.1039665245.squirrel@www.csn.ul.ie>
X-Mailer: Sylpheed version 0.8.6cvs15 (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="6Rb1ygcS0sfv?N=."
Subject: Re: 2.4.20-ac2 and i810 drm
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--6Rb1ygcS0sfv?N=.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

The DRM updates are causing a lot of problems like this for software
that needs hardware support. The updates were merged into Alan's tree
after 2.4.20-rc2-ac2 and are still somewhat present in 2.4.20-ac2. On my
Radeon Mobility, GL-based apps wouldn't even start.

Arjan was fixing DRM all over the place a while ago, but not
lately. Notably the Rage 128 support was fixed by him, and the Radeon
support to some extent.

-Josh

Rabid cheeseburgers forced"Dave Airlie"<airlied@linux.ie> to
write this on Thu, 12 Dec 2002 03:54:05-0000(GMT):	

> 
> I've been running 2.4.20-rc4 up to now with DRM enabled for my i810
> chipset and XFree86 4.2 from RH 7.3.
> 
> When I run my OpenGL application (internal app) under 2.4.20-ac2 with
> the same .config when I ctrl-c the application the machine hangs hard.
> 
> It is the only application running on the X server so the X server
> restarts when I exit the app.. under 2.4.20-rc4 this works fine...
> 
> Dave.
> 
> -- 
> David Airlie, Software Engineer
> http://www.skynet.ie/~airlied / airlied@skynet.ie
> pam_smb / Linux DecStation / Linux VAX / ILUG person
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


-- 
=====
Joshua Kwan
joshk@mspencer.net
pgp public key at http://ludicrus.ath.cx/pubkey_gpg.asc
 
Money can't buy love, but it improves your bargaining position.
		-- Christopher Marlowe

--6Rb1ygcS0sfv?N=.
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE9+BiV6TRUxq22Mx4RAu5cAKC5QAe+GS2aXo+flkLrN5J4OgZkIgCeKqH3
0rXvQqpSFyk4ax+o9w/RTVc=
=2VvP
-----END PGP SIGNATURE-----

--6Rb1ygcS0sfv?N=.--
