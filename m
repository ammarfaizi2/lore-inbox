Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270243AbTGRRVE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 13:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270244AbTGRRVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 13:21:04 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:24961 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S270243AbTGRRVC (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 13:21:02 -0400
Message-Id: <200307181735.h6IHZuq3006920@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: LVM/device mapper support for 2.6.0-test1? 
In-Reply-To: Your message of "Fri, 18 Jul 2003 12:55:02 EDT."
             <Pine.LNX.4.53.0307181254130.5747@localhost.localdomain> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.53.0307181254130.5747@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1853664112P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 18 Jul 2003 13:35:56 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1853664112P
Content-Type: text/plain; charset=us-ascii

On Fri, 18 Jul 2003 12:55:02 EDT, "Robert P. J. Day" <rpjday@mindspring.com>  said:
> 
>   any pointers to LVM[2] support for 2.6?  that last message
> for LVM and device mapper referred only to 2.4.  thanks.

I've been running the  LVM2.2.00.01-rc2 and device-mapper.1.00.01-rc2
code with Joe Thornber's 'dm v4 ioctl' patch, and it works just fine except
for the lack of pvmove.


--==_Exmh_-1853664112P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/GC/7cC3lWbTT17ARArz8AKC3wGsQwOgD19NSDPMiBvCPTPVN1gCeIv5e
4+xszTz+m7SWePg/yRZYhwY=
=7KnU
-----END PGP SIGNATURE-----

--==_Exmh_-1853664112P--
