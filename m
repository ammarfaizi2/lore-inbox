Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268043AbUJSGd6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268043AbUJSGd6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 02:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268039AbUJSGd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 02:33:58 -0400
Received: from cerebus.immunix.com ([198.145.28.33]:12439 "EHLO
	haldeman.int.wirex.com") by vger.kernel.org with ESMTP
	id S268043AbUJSGds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 02:33:48 -0400
Date: Mon, 18 Oct 2004 23:33:44 -0700
From: Seth Arnold <sarnold@immunix.com>
To: linux-kernel@vger.kernel.org
Subject: setterm -msg off broken in 2.6.9
Message-ID: <20041019063344.GC4415@immunix.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IpbVkmxF4tDyP/Kb"
Content-Disposition: inline
X-Paranoia-1: Greetings CIA, FBI, MI5, NSA, ATF, Treasury, Ashcroft, Immigration!
X-Paranoia-2: A huge shout-out to my Big Brother, John Poindexter!
X-Paranoia-3: All your base are belong to U.S.
X-spamtrap: smart.monkies@nanas.surriel.com
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IpbVkmxF4tDyP/Kb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello, I'm using 2.6.9 on my ibook g3 700mhz, debian unstable.

I use setterm -msg off to turn off kernel log buffer to console from
time to time. It now reports an error:
$ setterm -msg off
klogctl error: Unknown error 4294967295

kernel log messages are still printed to the console.

Thanks


--IpbVkmxF4tDyP/Kb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBdLVI+9nuM9mwoJkRAo37AKCVYPkmEz/KqcD7Cl4YRbZixzk+TwCghXsF
SxRx/1bAHEonNseR4Ux7wWc=
=xllg
-----END PGP SIGNATURE-----

--IpbVkmxF4tDyP/Kb--
