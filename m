Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263178AbTKPS0b (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 13:26:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263181AbTKPS0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 13:26:31 -0500
Received: from h80ad26be.async.vt.edu ([128.173.38.190]:43148 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263178AbTKPS03 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 13:26:29 -0500
Message-Id: <200311161826.hAGIQELa030180@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: gene.heskett@verizon.net
Cc: Tim Schmielau <tim@physik3.uni-rostock.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.0-test9 - document elevator= parameter 
In-Reply-To: Your message of "Sun, 16 Nov 2003 12:33:05 EST."
             <200311161233.05347.gene.heskett@verizon.net> 
From: Valdis.Kletnieks@vt.edu
References: <200311160259.hAG2x4La006117@turing-police.cc.vt.edu> <Pine.LNX.4.53.0311161510280.14183@gockel.physik3.uni-rostock.de> <200311161657.hAGGvRLa028307@turing-police.cc.vt.edu>
            <200311161233.05347.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_2096679506P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 16 Nov 2003 13:26:14 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_2096679506P
Content-Type: text/plain; charset=us-ascii

On Sun, 16 Nov 2003 12:33:05 EST, Gene Heskett said:

> since I'm running a test9-mm3 kernel, where might i find a discussion 
> of this scheduler?

Well, all the source is in drivers/block/cfq-iosched.c and here's
Jens Axboe explaining it:

http://marc.theaimsgroup.com/?l=linux-kernel&m=104495457606855&w=2

--==_Exmh_2096679506P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/t8FGcC3lWbTT17ARAjoIAKDp57VmyjMsrGDOkCU99DGgvmg6NACg9aW0
2NkdLpziqYAtTlVP3KiZu9g=
=bulE
-----END PGP SIGNATURE-----

--==_Exmh_2096679506P--
