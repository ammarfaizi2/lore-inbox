Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261782AbTJWUS5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 16:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261806AbTJWUS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 16:18:57 -0400
Received: from baloney.puettmann.net ([194.97.54.34]:13484 "EHLO
	baloney.puettmann.net") by vger.kernel.org with ESMTP
	id S261782AbTJWUSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 16:18:55 -0400
Date: Thu, 23 Oct 2003 22:17:59 +0200
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test8-bk1 cpufreq problem
Message-ID: <20031023201758.GA16762@puettmann.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Ruben Puettmann <ruben@puettmann.net>
X-Scanner: exiscan *1ACluB-0004NR-00*aeHvBgX3YH.* (Puettmann.NeT, Germany)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


        hy,

I have a problem with the intel speedstep things.=20

Hardware: IBM Thinkpad R40 2722-GDG/D
Kernel: 2.6.0-test8-bk1

If I boot it with ac enable cat /proc/cpufreq shows as maximum cpu
frequency the whole 1499 Mhz. If I boot with ac disable cat
/proc/cpufreq shows as maximum cpu frequency 599790 khz (100%).

So the cpu will be max in 599 Mhz if the thinkpad was bootet from
battery.

        Ruben




--=20
Ruben Puettmann
ruben@puettmann.net
http://www.puettmann.net

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/mDd2gHHssbUmOEIRAsFNAJ4h3Rt1nqB26iqbiHQLBWuzuzoFPACeNEnz
riHFQTt6ZsryIxvy8bb2RTY=
=QdFt
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
