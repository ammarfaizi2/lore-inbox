Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270175AbTG2Can (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 22:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270430AbTG2Can
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 22:30:43 -0400
Received: from h80ad244a.async.vt.edu ([128.173.36.74]:7552 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S270175AbTG2Cam (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 22:30:42 -0400
Message-Id: <200307290230.h6T2UcS5002757@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Ronald Jerome <imun1ty@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RPM QUESTION 
In-Reply-To: Your message of "Mon, 28 Jul 2003 16:33:44 PDT."
             <20030728233344.43084.qmail@web13304.mail.yahoo.com> 
From: Valdis.Kletnieks@vt.edu
References: <20030728233344.43084.qmail@web13304.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-832939306P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 28 Jul 2003 22:30:38 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-832939306P
Content-Type: text/plain; charset="us-ascii"
Content-Id: <2744.1059445826.1@turing-police.cc.vt.edu>

On Mon, 28 Jul 2003 16:33:44 PDT, Ronald Jerome <imun1ty@yahoo.com>  said:
> Will RPM be working anytime soon in kernel-2.6.0-test
> series?

# uname -a
Linux turing-police.cc.vt.edu 2.6.0-test2-mm1 #2 Mon Jul 28 13:51:00 EDT 2003 i686 i686 i386 GNU/Linux
# id
uid=0(root) gid=0(root) groups=0(root),1(bin),2(daemon),3(sys),4(adm),6(disk),10(wheel)
# rpm -q rpm
rpm-4.2.1-0.11

RedHat Rawhide works for me.  The guys at RedHat are aware of the issue, and will
certainly have a working RPM by the time they ship a 2.6 kernel in a release (RH 9.2 at
the earliest, I'm guessing, as it looks like 9.1 is going to be shipping the customary
RedHat mutation of 2.4.20-ac<mumble>)

--==_Exmh_-832939306P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD4DBQE/JdxOcC3lWbTT17ARAim9AJd7k/RlsmO4oKBbzjrBEXuiKX++AJ9PhAwm
rcusGMAibThu3S77MwWYsw==
=u1ys
-----END PGP SIGNATURE-----

--==_Exmh_-832939306P--
