Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261830AbUKCTiH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261830AbUKCTiH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 14:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbUKCTfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 14:35:55 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:48543 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261830AbUKCTdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 14:33:54 -0500
Message-Id: <200411031933.iA3JXfAL020148@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 10/11/2004 with nmh-1.1-RC3
To: gheskett@wdtv.com
Cc: linux-kernel@vger.kernel.org, DervishD <lkml@dervishd.net>,
       =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: is killing zombies possible w/o a reboot? 
In-Reply-To: Your message of "Wed, 03 Nov 2004 14:26:23 EST."
             <200411031426.23880.gheskett@wdtv.com> 
From: Valdis.Kletnieks@vt.edu
References: <200411030751.39578.gene.heskett@verizon.net> <200411031353.39468.gene.heskett@verizon.net> <200411031906.iA3J6QCj018875@turing-police.cc.vt.edu>
            <200411031426.23880.gheskett@wdtv.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-610972816P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 03 Nov 2004 14:33:40 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-610972816P
Content-Type: text/plain; charset=us-ascii

On Wed, 03 Nov 2004 14:26:23 EST, Gene Heskett said:

> Well, since the "device", a bt878 based Haupagge tv card is sitting in 
> a pci socket, thats even more drastic than a reboot.

Not if you have a good hot-swap PCI cage. ;)

Anyhow, that points even more at a driver issue for the bt878 -
if you can get Sysrq-T output, where does it say the hung process is
inside the kernel?

--==_Exmh_-610972816P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBiTKUcC3lWbTT17ARAntKAKCmNwGNfrDi1UT8bTy9Pp4Ejh0MYwCg5xTQ
6BRaP9vydH9bKOx31xDAPEY=
=u4kJ
-----END PGP SIGNATURE-----

--==_Exmh_-610972816P--
