Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263422AbTCNQNk>; Fri, 14 Mar 2003 11:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263423AbTCNQNk>; Fri, 14 Mar 2003 11:13:40 -0500
Received: from itaqui.terra.com.br ([200.176.3.19]:38577 "EHLO
	itaqui.terra.com.br") by vger.kernel.org with ESMTP
	id <S263422AbTCNQNj>; Fri, 14 Mar 2003 11:13:39 -0500
Date: Fri, 14 Mar 2003 13:29:18 -0400
From: Rhino <rhino9@terra.com.br>
To: linux-kernel@vger.kernel.org
Subject: NPTL, backwards compatibility ?
Message-Id: <20030314132918.62bc63e1.rhino9@terra.com.br>
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=._t5yv_eFlQe80v"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=._t5yv_eFlQe80v
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Sorry for bothering,
But i could not find a good resource on the topic.

I'm currently using beta-kernels (2.5.64-mm4/6) and glibc 2.3.2, for taking advantage of NPTL and enabling backwards
compatibility should be safe to configure glibc with --enable-kernel=2.4.19 and 
using LD_ASSUME_KERNEL=2.4.19 $application .

is this correct ?

--=._t5yv_eFlQe80v
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+chFza+NSpfNJFaARAg3bAJ4qwkU7xvswoPjW6/2e9WyG5pyGiACfdc6C
JqJvzklDtdWsRaHKUE2pHpo=
=ym9p
-----END PGP SIGNATURE-----

--=._t5yv_eFlQe80v--
