Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbTEESFd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 14:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261183AbTEESFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 14:05:33 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:46720 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261180AbTEESFb (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 14:05:31 -0400
Message-Id: <200305051817.h45IHwJC003355@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Steven Cole <elenstev@mesatop.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
       Larry McVoy <lm@bitmover.com>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Kernel hot-swap using Kexec, BProc and CC/SMP Clusters. 
In-Reply-To: Your message of "Mon, 05 May 2003 12:00:15 MDT."
             <1052157615.2163.113.camel@spc9.esa.lanl.gov> 
From: Valdis.Kletnieks@vt.edu
References: <1052140733.2163.93.camel@spc9.esa.lanl.gov> <m1d6ixb8m7.fsf@frodo.biederman.org>
            <1052157615.2163.113.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1876400151P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 05 May 2003 14:17:57 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1876400151P
Content-Type: text/plain; charset=us-ascii

On Mon, 05 May 2003 12:00:15 MDT, Steven Cole said:

> Perhaps two uptimes could be kept. The current concept of uptime would
> remain as is, analogous to the reign of a king (the current kernel), and
> a new integrated uptime would be analogous to the life of a dynasty. The
> dynasty uptime would be one of the many things the new kernel learned
> about on booting. This new dynasty uptime could become quite long if
> everything keeps on ticking.

Make sure you handle the case of a dynasty that starts on a 2.7.13 kernel
and is finally deposed by a power failure in 2.7.39.


--==_Exmh_-1876400151P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+tqrVcC3lWbTT17ARAnImAKCkobfhiQB38EJnBT8hZ9Exw9x91QCgr4zJ
7wEJoMp7pR4si/SpgpGxDHs=
=rZRL
-----END PGP SIGNATURE-----

--==_Exmh_-1876400151P--
