Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268461AbTANA4m>; Mon, 13 Jan 2003 19:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268459AbTANA4m>; Mon, 13 Jan 2003 19:56:42 -0500
Received: from h80ad26f3.async.vt.edu ([128.173.38.243]:59264 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S268461AbTANA4l>; Mon, 13 Jan 2003 19:56:41 -0500
Message-Id: <200301140105.h0E158qZ002813@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: Felix von Leitner <leitner-linuxkernel@fefe.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel nfsd module depmod error 
In-Reply-To: Your message of "Tue, 14 Jan 2003 01:33:24 +0100."
             <20030114003324.GA18358@fefe.de> 
From: Valdis.Kletnieks@vt.edu
References: <20030114003324.GA18358@fefe.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1440036616P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 13 Jan 2003 20:05:08 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1440036616P
Content-Type: text/plain; charset=us-ascii

On Tue, 14 Jan 2003 01:33:24 +0100, Felix von Leitner <leitner-linuxkernel@fefe.de>  said:
> Compiling the kernel nfsd as module fails at "make modules_install" with
> depmod reporting a gazillion unresolved symbols.  This has been broken
> for several versions now, it should really be fixed.  I have not tried
> to compile the kernel nfsd into the kernel.

Have you tried Rusty's latest module-init-tools? 0.9.8 fixed a lot of
problems for me....

--==_Exmh_1440036616P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+I2JDcC3lWbTT17ARAradAJ9uoghdlXZ/peya4Wo2xihZkP3YhwCeId5n
sH4yOATjyKPWHFJeNPMhFnA=
=nt7h
-----END PGP SIGNATURE-----

--==_Exmh_1440036616P--
