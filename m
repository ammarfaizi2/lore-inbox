Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286263AbRLTOdq>; Thu, 20 Dec 2001 09:33:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286261AbRLTOdg>; Thu, 20 Dec 2001 09:33:36 -0500
Received: from gateway-2.hyperlink.com ([213.52.152.2]:23824 "EHLO
	core-gateway-1.hyperlink.com") by vger.kernel.org with ESMTP
	id <S286260AbRLTOdY>; Thu, 20 Dec 2001 09:33:24 -0500
Subject: Re: asymmetric multiprocessing
From: "Martin A. Brooks" <martin@jtrix.com>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0112200912480.7795-100000@coffee.psychology.mcmaster.ca>
In-Reply-To: <Pine.LNX.4.33.0112200912480.7795-100000@coffee.psychology.mcmaster.ca>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-BpgmAwUoebS95qCicxH3"
X-Mailer: Evolution/1.0 (Preview Release)
Date: 20 Dec 2001 14:33:22 +0000
Message-Id: <1008858802.431.43.camel@unhygienix>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-BpgmAwUoebS95qCicxH3
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2001-12-20 at 14:13, Mark Hahn wrote:
> not supported (and frowned upon by the spec).  the issue is TSC,
> of course, and it's definitely not clear whether the normal case
> (correctly configured SMP) should be burdoned by support for=20
> mixed-clock chips.

I'm no expert on MP, hence I fail to see why differing clock speeds
between CPUs should be a problem providing the system bus rates are
constant. As each CPU would be rated differently as far as bogomips are
concerned, couldn't the scheduler apply load accordingly?


--=20
Martin A. Brooks   Systems Administrator
Jtrix Ltd          t: +44 7395 4990
57-59 Neal Street  f: +44 7395 4991
London, WC2H 9PP   e: martin@jtrix.com

--=-BpgmAwUoebS95qCicxH3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEABECAAYFAjwh9rIACgkQwgE0gTKdDobL4gCggWd+Vfz+PuzonBXX+VyxB7Sj
Ms8An1QUlRcC1Y4oIyj8m6XacjUFt7Vq
=rFsD
-----END PGP SIGNATURE-----

--=-BpgmAwUoebS95qCicxH3--

