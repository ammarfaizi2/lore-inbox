Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264619AbTEPXsM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 19:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264632AbTEPXsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 19:48:12 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:7040 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S264619AbTEPXsL (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 19:48:11 -0400
Message-Id: <200305170001.h4H0113n001351@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.68 FUTEX support should be optional 
In-Reply-To: Your message of "Fri, 16 May 2003 22:55:42 BST."
             <1053122141.5589.45.camel@dhcp22.swansea.linux.org.uk> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.44.0305141758070.28007-100000@home.transmeta.com>
            <1053122141.5589.45.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_607840616P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 16 May 2003 20:01:01 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_607840616P
Content-Type: text/plain; charset=us-ascii

On Fri, 16 May 2003 22:55:42 BST, Alan Cox said:

> There are arguments in some cases for avoiding the selections (notably
> adding a zillion ifdefs to remove something thats utterly trivial) but
> providing most users see only
> 
> 	Remove kernel features for embedded systems (Y/N)
> 
> its no more dangerous/hassle than the kernel debug menu

OK.. I know I argued against making it visible to the user at all, but if it's
phrased like that, it will at least (hopefully) dissuade everybody who
doesn't know what an embedded system is.

And after all, Linux isn't about dissuading the truly determined, nor is it
about making moral judgements regarding their wizardry/idiocy ratio....

--==_Exmh_607840616P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+xXu8cC3lWbTT17ARAqJ5AKCw/aroGXLDb41fwQ7e0NJql4Fw0gCg9p/m
iVHErVmrPWLkUDgqPo5o66k=
=V2Oo
-----END PGP SIGNATURE-----

--==_Exmh_607840616P--
