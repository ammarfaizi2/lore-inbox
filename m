Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280855AbRKGRqN>; Wed, 7 Nov 2001 12:46:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280842AbRKGRqF>; Wed, 7 Nov 2001 12:46:05 -0500
Received: from tabaluga.ipe.uni-stuttgart.de ([129.69.22.180]:26752 "EHLO
	tabaluga.ipe.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id <S280855AbRKGRpx>; Wed, 7 Nov 2001 12:45:53 -0500
From: Nils Rennebarth <nils@ipe.uni-stuttgart.de>
Date: Wed, 7 Nov 2001 18:45:45 +0100
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: hfhsu@sis.com.tw
Subject: Network driver for SiS 735 available?
Message-ID: <20011107184545.H14389@ipe.uni-stuttgart.de>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	hfhsu@sis.com.tw
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OgApRN/oydYDdnYz"
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OgApRN/oydYDdnYz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I have a new Elitegroup K7S5A with the integrated SiS 735 chip.

The stock 2.4.14 kernel does recognize the network chip.  From looking at
the mainboard, it also correctly recognizes the "Realtek RTL8201 PHY".

It even outputs the right messages (i.e.: No Media, Full duplex 100MBit,
Half duplex 10MBit, ...) when I plug the cable into our switch or hub, but
never transmits nor receives any packets.

Any suggestions what I could try/how I could debug the driver?

Nils

--
                                     ______
                                    (Muuuhh)
Global Village Sau  =3D=3D>        ^..^ |/=AF=AF=AF=AF=AF
(Kann Fremdsprache) =3D=3D>        (oo)

--OgApRN/oydYDdnYz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE76XNJqgAZ+sZlgs4RAmTCAKCVtHK5aRwxDUG3+dZ0spKlBiyMxQCg6ERQ
PcSQ5rbHo9o/3X0wiu0SVJY=
=IgwR
-----END PGP SIGNATURE-----

--OgApRN/oydYDdnYz--
