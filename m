Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262628AbTCTBr1>; Wed, 19 Mar 2003 20:47:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262893AbTCTBr1>; Wed, 19 Mar 2003 20:47:27 -0500
Received: from adsl-67-121-154-32.dsl.pltn13.pacbell.net ([67.121.154.32]:7392
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id <S262628AbTCTBr0>; Wed, 19 Mar 2003 20:47:26 -0500
Date: Wed, 19 Mar 2003 17:58:23 -0800
To: Brad Laue <brad@brad-x.com>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Kernels 2.2 and 2.4 exploit (ALL VERSION WHAT I HAVE TESTED UNTILL NOW!) - removed link
Message-ID: <20030320015823.GB4821@triplehelix.org>
References: <000701c2ee22$efe61fd0$0100a8c0@andrus> <01f001c2ee5b$f418dd20$294b82ce@connecttech.com> <3E78FA9C.3000707@brad-x.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
In-Reply-To: <3E78FA9C.3000707@brad-x.com>
User-Agent: Mutt/1.5.3i
From: Joshua Kwan <joshk@triplehelix.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2003 at 06:17:48PM -0500, Brad Laue wrote:
> My problem is with the fix for 2.4.x; last I checked, XFree86 et al=20
> should not be surrounded by square brackets, such as is the case now:

But .. does anything weird happen?
I've noticed it too; no big deal, everything is still running fine...

nobody   16966  0.0  0.8  4132 1120 ?        S    Mar18   0:00 [proftpd]
www-data 22277  0.0  0.6 137464 796 ?        S    Mar18   0:00 [apache]
www-data 22278  0.0  0.7 137424 1012 ?       S    Mar18   0:00 [apache]
www-data 22279  0.0  0.6 137424 864 ?        S    Mar18   0:00 [apache]
www-data 22280  0.0  0.9 137452 1216 ?       S    Mar18   0:00 [apache]
www-data 22281  0.0  0.5 137412 748 ?        S    Mar18   0:00 [apache]
www-data 22282  0.0  0.6 137448 772 ?        S    Mar18   0:00 [apache]
www-data 22333  0.0  0.6 137416 852 ?        S    Mar18   0:00 [apache]
www-data 29197  0.0  0.9 137420 1264 ?       S    05:48   0:00 [apache]
root      4799  0.1  1.4  6628 1820 ?        S    17:24   0:02 [sshd]
joshk     4801  0.0  1.2  3832 1644 pts/1    S    17:24   0:00 -bash
irc       4815  0.0  0.5  2996  680 ?        S    17:25   0:00 -slink 10 10=
 12 1
joshk     4821  0.9  2.9  6208 3804 pts/1    S    17:26   0:17 mutt
root      5123  5.0  1.4  6700 1848 ?        S    17:56   0:00 [sshd]
joshk     5125  9.0  1.2  3820 1632 pts/2    S    17:56   0:00 -bash
joshk     5128  0.0  0.5  2488  752 pts/2    R    17:56   0:00 ps aux

Regards,
Josh

--=20
New PGP public key: 0x27AFC3EE

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+eSA+T2bz5yevw+4RAtXlAJ9PVpVFzlI8hTX+xvmuqn/EKH9AegCgmx59
uc4guto5DJRoR/3rPW+Zsro=
=yAYq
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
