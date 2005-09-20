Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965065AbVITSoO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965065AbVITSoO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 14:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965068AbVITSoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 14:44:14 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:63912 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S965065AbVITSoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 14:44:14 -0400
Message-Id: <200509201843.j8KIhadu020970@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: 7eggert@gmx.de
Cc: Keith Owens <kaos@ocs.com.au>, Ben Dooks <ben-linux@fluff.org>,
       linux-kernel@vger.kernel.org, patch-out@fluff.rog
Subject: Re: [PATCH] scripts - use $OBJDUMP to get correct objdump (cross compile) 
In-Reply-To: Your message of "Tue, 20 Sep 2005 18:55:22 +0200."
             <E1EHlOt-00012f-Au@be1.lrz> 
From: Valdis.Kletnieks@vt.edu
References: <4OB3R-5gu-13@gated-at.bofh.it> <4OLPC-3NQ-19@gated-at.bofh.it>
            <E1EHlOt-00012f-Au@be1.lrz>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1127241816_3303P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 20 Sep 2005 14:43:36 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1127241816_3303P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Tue, 20 Sep 2005 18:55:22 +0200, Bodo Eggert said:

> Having a space as the option delimiter will break if the path to objdum=
p
> contains a space. Therefore you'll need to use an array.

No. You need to draw the line somewhere.  You let them have a space in th=
e
path, the next thing you know the'll be back asking why a UTF-8 encoded
non-breaking-white-space in the path doesn't work. :)

--==_Exmh_1127241816_3303P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDMFhYcC3lWbTT17ARAppVAKCIQGLBcA/y1GScDQguy8bCR0dSTgCfd4oJ
BrGfhxsbS2t6qkm0/77PC98=
=+CFk
-----END PGP SIGNATURE-----

--==_Exmh_1127241816_3303P--
