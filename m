Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262120AbTKHU7g (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 15:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbTKHU7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 15:59:36 -0500
Received: from h80ad26cf.async.vt.edu ([128.173.38.207]:53129 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262120AbTKHU7f (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 15:59:35 -0500
Message-Id: <200311082059.hA8KxLZ2024645@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Markus =?ISO-8859-1?Q?H=E4stbacka?= <midian@ihme.org>
Cc: Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4] forcedeth 
In-Reply-To: Your message of "Sat, 08 Nov 2003 22:26:08 +0200."
             <1068323168.25759.4.camel@midux> 
From: Valdis.Kletnieks@vt.edu
References: <3FAC837F.2070601@gmx.net>
            <1068323168.25759.4.camel@midux>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-895699488P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 08 Nov 2003 15:59:20 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-895699488P
Content-Type: text/plain; charset=us-ascii

On Sat, 08 Nov 2003 22:26:08 +0200, Markus =?ISO-8859-1?Q?H=E4stbacka?= said:

> trust me, it was hard to edit lilo.conf so I even could boot back to old
> kernel when all the numbers just were jumping around)

And this is why you always leave at least one "known working" kernel in your
lilo.conf or grub.conf (I think I've got at least 4 kernels listed right now
that are known to boot and be at least stable enough to build a kernel).  Also
good for recovering from broken framebuffer drivers, kernels that hang at boot
before getting very far, and all sorts of other messes.


--==_Exmh_-895699488P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/rVkocC3lWbTT17ARAo+yAJ9HEJlKdah7prr7fTnFW6SvynPxYgCg3kFD
8fgE8NAMV9JEU1Jv4t9jtSs=
=MrJ5
-----END PGP SIGNATURE-----

--==_Exmh_-895699488P--
