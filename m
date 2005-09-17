Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750856AbVIQEKH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbVIQEKH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 00:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750865AbVIQEKH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 00:10:07 -0400
Received: from h80ad257c.async.vt.edu ([128.173.37.124]:59272 "EHLO
	h80ad257c.async.vt.edu") by vger.kernel.org with ESMTP
	id S1750856AbVIQEKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 00:10:05 -0400
Message-Id: <200509170409.j8H499mq003691@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Andrew Morton <akpm@osdl.org>
Cc: greg@kroah.com, kay.sievers@vrfy.org, jirislaby@gmail.com,
       dominik.karall@gmx.net, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc1-mm1 
In-Reply-To: Your message of "Fri, 16 Sep 2005 17:15:53 PDT."
             <20050916171553.35b30af2.akpm@osdl.org> 
From: Valdis.Kletnieks@vt.edu
References: <20050916022319.12bf53f3.akpm@osdl.org> <200509162042.07376.dominik.karall@gmx.net> <432B2101.9080806@gmail.com> <20050916195903.GE22221@vrfy.org> <20050916213003.GB13604@kroah.com> <200509162353.j8GNrX2B007036@turing-police.cc.vt.edu>
            <20050916171553.35b30af2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1126930143_2814P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 17 Sep 2005 00:09:04 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1126930143_2814P
Content-Type: text/plain; charset=us-ascii

On Fri, 16 Sep 2005 17:15:53 PDT, Andrew Morton said:

> Or you can take your chances with
> http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.14-rc1-mm1.5.gz which
> is kinda rc1-mm1 without those 28 patches.

Builds and boots on my laptop.  Everything seems functional except for
ethernet and wireless, which I can't test till next I make it to the office.
Whatever problem Martin Bligh hit with networking doesn't seem to affect
PPP dialup on my machine. Udev, mice, and X are all (expectedly) happy....

--==_Exmh_1126930143_2814P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDK5bfcC3lWbTT17ARAnbIAKCbXBNmhf/yKFWWLx3F8XXA0wnmiwCglgm2
IK9UhEVMw1Gvbr8rPxDDhMI=
=0X7l
-----END PGP SIGNATURE-----

--==_Exmh_1126930143_2814P--
