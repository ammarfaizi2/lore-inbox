Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262187AbTIMUfb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 16:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262188AbTIMUfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 16:35:31 -0400
Received: from adsl-67-124-157-90.dsl.pltn13.pacbell.net ([67.124.157.90]:992
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id S262187AbTIMUfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 16:35:20 -0400
Date: Sat, 13 Sep 2003 13:35:18 -0700
To: Thomas Molina <tmolina@cablespeed.com>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: presario laptop pcmcia loading problems
Message-ID: <20030913203518.GJ27104@triplehelix.org>
Mail-Followup-To: joshk@triplehelix.org,
	Thomas Molina <tmolina@cablespeed.com>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0309121603280.1579-800000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BEa57a89OpeoUzGD"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309121603280.1579-800000@localhost.localdomain>
User-Agent: Mutt/1.5.4i
From: Joshua Kwan <joshk@triplehelix.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BEa57a89OpeoUzGD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2003 at 04:20:23PM -0400, Thomas Molina wrote:
> # CONFIG_ISA is not set

Try enabling this, it fixed it for me the last time something akin to
this happened to me - orinoco_cs wouldn't work, after enabling this it
did...

--=20
Joshua Kwan

--BEa57a89OpeoUzGD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iQIVAwUBP2N/haOILr94RG8mAQLW5xAAhXr6cbwvrA3IjkreKvpsvMmSDIP9R8jd
9XlgONvXvs6SN0B0UsyfRropSmcmEbABmfqEuwBgT2gSgu8YErO88lWLip9pKb7e
ysjfu+BSer5iyj1CpuboUa80Z3oG4ynqjrddWwBOGzzy3K+uDc4y/033hBUZg7k8
hyW7Mf53+5WxEbeiTS/jD2tAzqsbtX+Pmivv70j9IQ+8C5ptG4NoMl3GxG0lQm+w
fmx5OAEjVVDTHZNtnwUPQ/W7wLpt7Ey78VEfOSqfKjzUNV57qJaIqesKQgvM+fwT
EQdJR81fMAg20wUujv9dUPSV6w5gpfrREM0AAJcIu/qf1wibUPCC72iD0aXUUHk4
LZGO6FW7jLB00n8vBqCKbICqP+9qPFyio539jI40ZmnipFr96zmYA28T0i41SJSX
KOHmAjiIaYi+vjVbgL2r4F9W3nuqe2dEpYD1WvTbkY7e/wAJZpodyD7aHlkZ+7KL
5XThZccYGecSMHz4HqkjQE+YpyO8KcVlqc4YIdWX3Q3IKOglCOT55dqq615xunc7
fFqPZ4Z21pT8hoJVe/edCRC8ihLDsAAjqA2me5JVZDOwCQBaJVw1IBak/hIjhAcn
bcIVPvji6AjxRq324s0zpuV+hlUhtZSX/HoJOkBaLuXXp4SDIfQQHeyZBJWjgfpb
3gu5PXoawFs=
=T0Hz
-----END PGP SIGNATURE-----

--BEa57a89OpeoUzGD--
