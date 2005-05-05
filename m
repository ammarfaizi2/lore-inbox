Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262121AbVEEO5Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262121AbVEEO5Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 10:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbVEEO5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 10:57:25 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:22801 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262121AbVEEO5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 10:57:19 -0400
Message-Id: <200505051457.j45EvAm6013062@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc3-mm3 
In-Reply-To: Your message of "Wed, 04 May 2005 22:10:57 PDT."
             <20050504221057.1e02a402.akpm@osdl.org> 
From: Valdis.Kletnieks@vt.edu
References: <20050504221057.1e02a402.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1115305030_3889P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 05 May 2005 10:57:10 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1115305030_3889P
Content-Type: text/plain; charset=us-ascii

On Wed, 04 May 2005 22:10:57 PDT, Andrew Morton said:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc3/2.6.12-rc3-mm3/
> 
> - device mapper updates
> 
> - more UML updates
> 
> - -mm seems unusually stable at present.

Indeed.  Line counts for the announcement e-mails for the 2.6.12-rc*-mm*:

2.6.12-rc1-mm1 2345
2.6.12-rc1-mm2 3048
2.6.12-rc1-mm3 2861
2.6.12-rc1-mm4 2612
2.6.12-rc2-mm1 2460
2.6.12-rc2-mm2 2610
2.6.12-rc2-mm3 2763
2.6.12-rc3-mm1 1236
2.6.12-rc3-mm2  105
2.6.12-rc3-mm3  796

(Presuming that the linecounts are at least roughly proportional to the
churn in patches added/merged/dropped).  The surprising thing for me this
time around was the 223 "merged upstream" patches - seemed a bit high for
this point in -rc3.  I admit *not* having looked at the list in detail and
they might all be minor bugfixes, or compared it to similar stages of
previous -rc3's.

And yes, it compiles and boots cleanly on my Dell laptop, for what that's worth. ;)

--==_Exmh_1115305030_3889P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCejRFcC3lWbTT17ARAp8tAJ93de2Fy5oA73Ho7nMFbVnuZIOPxACfaK87
mAuGHZ6/5wiaSrVxa8SRrSk=
=m+gg
-----END PGP SIGNATURE-----

--==_Exmh_1115305030_3889P--
