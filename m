Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264461AbTGGUbJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 16:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264456AbTGGUbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 16:31:09 -0400
Received: from smtp800.mail.sc5.yahoo.com ([66.163.168.179]:380 "HELO
	smtp800.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264461AbTGGUbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 16:31:06 -0400
Subject: Unable to grab 2.5 tree via bkbits
From: Stephen Torri <storri@sbcglobal.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-bO+6Capwpw/Y5AoTi3mn"
Organization: 
Message-Id: <1057610739.11432.18.camel@base>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4- 
Date: 07 Jul 2003 15:45:39 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-bO+6Capwpw/Y5AoTi3mn
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I am trying to grab the kernel via bk but I am not able to find the
rigth directory. My first attempt was as follows:

>$ bk clone http://linux.bkbits.net/linux-2.5 linux-2.5
Clone http://linux.bkbits.net/linux-2.5 -> file://usr/src/linux-2.5
linux-2.5: No such file or directory

Yet when I when I viewed the hosted projects at www.bkbits.net I noticed
that there was a linus project for the kernel. So I tried that:

>$ bk clone http://linus.bkbits.net/linux-2.5 linux-2.5
Clone http://linus.bkbits.net/linux-2.5 -> file://usr/src/linux-2.5
linux-2.5: No such file or directory

So far I see no messages that alert me to a problem with bkbits.net so I
am suspecting the problem is on my end. Can someone show me the errors
of my ways?

Stephen
--=20
Stephen Torri <storri@sbcglobal.net>

--=-bO+6Capwpw/Y5AoTi3mn
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/CdvzmXRzpT81NcgRAm0bAKC+RCF9yR5IPa89w4Dup/2tGHCXYwCgjyPl
dT59sP/VWr//YnlWuknnO7U=
=0LkK
-----END PGP SIGNATURE-----

--=-bO+6Capwpw/Y5AoTi3mn--

