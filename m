Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290113AbSAQSUD>; Thu, 17 Jan 2002 13:20:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290112AbSAQSTo>; Thu, 17 Jan 2002 13:19:44 -0500
Received: from hal.astro.umn.edu ([128.101.221.100]:63630 "EHLO astro.umn.edu")
	by vger.kernel.org with ESMTP id <S290111AbSAQST3>;
	Thu, 17 Jan 2002 13:19:29 -0500
Date: Thu, 17 Jan 2002 12:19:23 -0600
From: kelley eicher <carde@astro.umn.edu>
To: linux-kernel@vger.kernel.org
Subject: safest verion of gcc to use?
Message-ID: <20020117121923.A7977@astro.umn.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi,

quick question here. [kernel-src]/Documentation/Changes and
[kernel-src]/README say two different things about which version of gcc
is recommended for the compiling of the linux kernel. README says egcs
1.1.2 and Documentation/Changes says to use gcc 2.95.3 or greater.
is the last egcs release still the preferred or has that changed to the
gcc 2.95.x releases?

i assume that README is outdated and should not mention a version of gcc
at all for compilation of the src. it seems that README instructs the user
to refer to Documentation/Changes for the latest info but makes it confusing
by stating, "Make sure you have gcc-2.91.66 (egcs-1.1.2) available."

-kelley=20


--=20

 >> kelley j eicher
<<  UNIX architect
 >> Univ. of MN Astronomy Dept.
<<  ph: (612) 626-2067 or (612) 624-3589
 >> fx: (612) 626-2029
<<  office: 385 physics
 >> carde at astro dot umn dot edu

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.2 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8RxWrF3O5KT+A1xQRAn0NAJ9zAPNcXHXj2Vi2xn+6mXcvx+NnkwCbB7Xz
oovHOwFV4+720ige45vuVug=
=qaJZ
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
