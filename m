Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264543AbRFOWTY>; Fri, 15 Jun 2001 18:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264542AbRFOWTO>; Fri, 15 Jun 2001 18:19:14 -0400
Received: from con-64-133-52-190-ria.sprinthome.com ([64.133.52.190]:52997
	"EHLO ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S264541AbRFOWTD>; Fri, 15 Jun 2001 18:19:03 -0400
Date: Fri, 15 Jun 2001 15:19:01 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Kernel Developer List <linux-kernel@vger.kernel.org>
Subject: Simple example of using slab allocator?
Message-ID: <20010615151901.G28394@one-eyed-alien.net>
Mail-Followup-To: Kernel Developer List <linux-kernel@vger.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="qoTlaiD+Y2fIM3Ll"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2001 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qoTlaiD+Y2fIM3Ll
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

For 2.5, I'm planning on switching my driver over to the slab allocator,
for a variety of reasons.  Does anyone have a _dead_ simple example of how
to use such a beast?  I've seen the various web pages and document
explaining the API, but I love to see working examples for reference (and
to fill in the blanks).

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

Okay, this isn't funny anymore! Let me down!  I'll tell Bill on you!!
					-- Microsoft Salesman
User Friendly, 4/1/1998

--qoTlaiD+Y2fIM3Ll
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7KonVz64nssGU+ykRAlH1AKDkZn8bclHrM8mdLyOSYoAEkPF6xgCfUkeN
cfWgD7ZRU8Y/PK8ekOXvoP4=
=53Z7
-----END PGP SIGNATURE-----

--qoTlaiD+Y2fIM3Ll--
