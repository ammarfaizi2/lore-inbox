Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262616AbSJBVjQ>; Wed, 2 Oct 2002 17:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262617AbSJBVjQ>; Wed, 2 Oct 2002 17:39:16 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:9415 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262616AbSJBVjN>; Wed, 2 Oct 2002 17:39:13 -0400
Date: Wed, 2 Oct 2002 23:44:33 +0200
From: Martin Waitz <tali@admingilde.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Trivial 2.5 patch] make orinoco_cs.c compile
Message-ID: <20021002214433.GA1484@admingilde.org>
References: <1033569586.28106.3.camel@plars>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
In-Reply-To: <1033569586.28106.3.camel@plars>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi :)

same problem with orinoco_cs.c:

--- linux-2.5.orig/drivers/net/wireless/orinoco_cs.c	2002-10-02 23:42:43.00=
0000000 +0200
+++ linux-2.5/drivers/net/wireless/orinoco_cs.c	2002-10-02 23:14:01.0000000=
00 +0200
@@ -32,7 +32,6 @@
 #include <linux/if_arp.h>
 #include <linux/etherdevice.h>
 #include <linux/wireless.h>
-#include <linux/tqueue.h>
=20
 #include <pcmcia/version.h>
 #include <pcmcia/cs_types.h>


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

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9m2jAj/Eaxd/oD7IRAv0aAJ43s7McXLIhMOFAsnaFsk9yEy0vewCeLYV2
0wt4OPiNLYuktkL/82OUgHU=
=CgoR
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
