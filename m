Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161117AbWGIUWk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161117AbWGIUWk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 16:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161118AbWGIUWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 16:22:40 -0400
Received: from pool-71-254-66-150.ronkva.east.verizon.net ([71.254.66.150]:60357
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1161117AbWGIUWj (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 16:22:39 -0400
Message-Id: <200607092019.k69KJt66005527@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Daniel Bonekeeper <thehazard@gmail.com>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: Automatic Kernel Bug Report
In-Reply-To: Your message of "Sun, 09 Jul 2006 16:01:58 EDT."
             <e1e1d5f40607091301j723b92bje147932a4395775c@mail.gmail.com>
From: Valdis.Kletnieks@vt.edu
References: <e1e1d5f40607090145k365c0009ia3448d71290154c@mail.gmail.com> <6bffcb0e0607090245t2dbcd394n86ce91eec661f215@mail.gmail.com> <e1e1d5f40607090329i25f6b1b2s3db2c2001230932c@mail.gmail.com> <20060709125805.GF13938@stusta.de> <e1e1d5f40607091146s2f8e6431v33923f38c6d10539@mail.gmail.com> <20060709191107.GN13938@stusta.de>
            <e1e1d5f40607091301j723b92bje147932a4395775c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1152476360_3401P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 09 Jul 2006 16:19:21 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1152476360_3401P
Content-Type: text/plain; charset=us-ascii

On Sun, 09 Jul 2006 16:01:58 EDT, Daniel Bonekeeper said:

> Sometimes the user may be just somebody that just started using linux,
> or is in an industry that has nothing related to computers. He doesn't
> even know that syslog exists, and even if he did, he could not even
> care about it.

This user will do whatever his distro tells him to do, which is almost
certainly something *other* than what a kernel.org kernel should do.
If he's running Ubuntu, it should do whatever Ubuntu does.  If he's
on Fedora Core, it should poke the RedHat bugzilla, and so on.

If he's running a kernel.org kernel, it's probably safe to assume *some*
level of clue

--==_Exmh_1152476360_3401P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEsWTIcC3lWbTT17ARArU5AKCwxd4Utej4o4PAdjvPS/zGIjPRKgCguyXJ
greIDmnhvSQvh5mGbNmJmUw=
=C8sC
-----END PGP SIGNATURE-----

--==_Exmh_1152476360_3401P--
