Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265833AbSKBAYO>; Fri, 1 Nov 2002 19:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265834AbSKBAYO>; Fri, 1 Nov 2002 19:24:14 -0500
Received: from mailout11.sul.t-online.com ([194.25.134.85]:31190 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S265833AbSKBAYN>; Fri, 1 Nov 2002 19:24:13 -0500
Date: Sat, 2 Nov 2002 01:30:27 +0100
From: Martin Waitz <tali@admingilde.org>
To: Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: cpu_devclass removed from cpu.h
Message-ID: <20021102003027.GD16236@admingilde.org>
Mail-Followup-To: Patrick Mochel <mochel@osdl.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T7mxYSe680VjQnyC"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--T7mxYSe680VjQnyC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi :)

the 'extern struct device_class cpu_devclass;' was removed from cpu.h
lately.
is this intentional or will it come back in some other include file?

i need that class to be able to register a interface for cpus
in my tree.


thanks

--=20
CU,		  / Friedrich-Alexander University Erlangen, Germany
Martin Waitz	//  [Tali on IRCnet]  [tali.home.pages.de] _________
______________/// - - - - - - - - - - - - - - - - - - - - ///
dies ist eine manuell generierte mail, sie beinhaltet    //
tippfehler und ist auch ohne grossbuchstaben gueltig.   /
			    -
Wer bereit ist, grundlegende Freiheiten aufzugeben, um sich=20
kurzfristige Sicherheit zu verschaffen, der hat weder Freiheit=20
noch Sicherheit verdient.
			Benjamin Franklin  (1706 - 1790)

--T7mxYSe680VjQnyC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE9wxyjj/Eaxd/oD7IRAhweAJ0cYGtO/cos0p9/3ol700BB6fEcTgCeOI5z
llrbvMibId4St3n/yccqA5I=
=r5Yp
-----END PGP SIGNATURE-----

--T7mxYSe680VjQnyC--
