Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316512AbSG3U10>; Tue, 30 Jul 2002 16:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316538AbSG3U10>; Tue, 30 Jul 2002 16:27:26 -0400
Received: from rdu26-81-135.nc.rr.com ([66.26.81.135]:9877 "EHLO
	max.bungled.net") by vger.kernel.org with ESMTP id <S316512AbSG3U10>;
	Tue, 30 Jul 2002 16:27:26 -0400
Date: Tue, 30 Jul 2002 16:30:50 -0400
From: Nathan Conrad <conrad@bungled.net>
To: linux-kernel@vger.kernel.org
Subject: DriverFS naming issues with VIA chipset
Message-ID: <20020730203050.GA9803@bungled.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On my Sony Vaio laptop, some device is named "VIA 82C686A/B". I think
that this is my southbridge chip. This causes problems because the
name has a slash inside of it. I get the following error from a find
command:

find: /driverfs/bus/pci/drivers/VIA 82C686A/B: No such file or directory

How should this be resolved?

-Nathan

--=20
Nathan J. Conrad                    https://bungled.net
101 Cynthia Drive / Chapel Hill, NC 27514-6614
GPG: F4FC 7E25 9308 ECE1 735C  0798 CE86 DA45 9170 3112


--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9Rvd6zobaRZFwMRIRAr0TAJ0aasN49HjJgmthG+Z7rj9mQAFDpACeM9qu
4Lr+tBkEFJTJKjhEThui14A=
=qRWD
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
