Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269453AbTCDOAn>; Tue, 4 Mar 2003 09:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269454AbTCDOAn>; Tue, 4 Mar 2003 09:00:43 -0500
Received: from 24-216-225-11.charter.com ([24.216.225.11]:28035 "EHLO
	wally.rdlg.net") by vger.kernel.org with ESMTP id <S269453AbTCDOAm>;
	Tue, 4 Mar 2003 09:00:42 -0500
Date: Tue, 4 Mar 2003 09:11:09 -0500
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: eepro100 ?
Message-ID: <20030304141109.GI646@rdlg.net>
Mail-Followup-To: Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5vjQsMS/9MbKYGLq"
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5vjQsMS/9MbKYGLq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



I have 2 machines with eepro100 cards.  I used the original driver for
them out of habit and on the last 2.4.20 kernel get A LOT of:

eth0: freeing mc frame.

in my dmesg log.  Out of curiosity I tried with the alternate driver and
that seems to have gone away.  Is one depreciated or are they both
viable and just different?   The help message doesn't really say much on
the topic.

< >     EtherExpressPro/100 support (eepro100, original Becker driver)
< >     EtherExpressPro/100 support (e100, Alternate Intel driver)

Robert

:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | PGP Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu=20
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

Diagnosis: witzelsucht  =09

IPv6 =3D robert@ipv6.rdlg.net	http://ipv6.rdlg.net
IPv4 =3D robert@mail.rdlg.net	http://www.rdlg.net

--5vjQsMS/9MbKYGLq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+ZLP98+1vMONE2jsRAibaAKCeiyntwVa0XB6+L+t6zhw41kCqygCgm2Fo
aTsMxZZd+NmQ9HLx/+/cVn8=
=2neH
-----END PGP SIGNATURE-----

--5vjQsMS/9MbKYGLq--
