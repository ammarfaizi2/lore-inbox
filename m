Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262669AbVDYRdD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262669AbVDYRdD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 13:33:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262738AbVDYRZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 13:25:05 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:37650 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262726AbVDYRWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 13:22:54 -0400
Message-Id: <200504251722.j3PHMalh017453@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Matthias-Christian Ott <matthias.christian@tiscali.de>
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH GIT 0.6] make use of register variables & size_t 
In-Reply-To: Your message of "Mon, 25 Apr 2005 18:59:42 +0200."
             <426D21FE.3040401@tiscali.de> 
From: Valdis.Kletnieks@vt.edu
References: <426CD1F1.2010101@tiscali.de> <Pine.LNX.4.58.0504250751330.18901@ppc970.osdl.org>
            <426D21FE.3040401@tiscali.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1114449756_5553P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 25 Apr 2005 13:22:36 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1114449756_5553P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Mon, 25 Apr 2005 18:59:42 +0200, Matthias-Christian Ott said:

> And if you think =22register=22 variables are outdated, please remove t=
he=20
> CONFIG_REGPARM option from the Kernel source.

I think you fail to understand the difference between what CONFIG_REGPARM=
 does
(namely, controlling the way parameters are passed to function calls) and=
 what
the 'register' declaration does....

> =5B2=5D Erik de Castro Lopo, Peter Aitken, Bradley L. Jones: Teach Your=
self=20
> C for Linux Programming in 21 Days; SAMS Publishing; 1999

Umm.. Yeah.  =22Teach yourself FOO in 21 days=22.  Quite the outstanding =
authority
to cite.  Gotta love the publisher too.. ;)


--==_Exmh_1114449756_5553P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCbSdccC3lWbTT17ARAh/fAKDZx1i+JXNXDQoeJMZnyytFn8nADQCeKgFC
gsbk15PHBohZYSzlymvPXYo=
=wfrs
-----END PGP SIGNATURE-----

--==_Exmh_1114449756_5553P--
