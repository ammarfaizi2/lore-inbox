Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263146AbTDVNrV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 09:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263139AbTDVNrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 09:47:21 -0400
Received: from h80ad2737.async.vt.edu ([128.173.39.55]:29568 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263163AbTDVNrU (ORCPT <RFC822;Linux-Kernel@Vger.Kernel.ORG>);
	Tue, 22 Apr 2003 09:47:20 -0400
Message-Id: <200304221359.h3MDx8sv003975@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: Andrew Morton <akpm@digeo.com>, Linux-Kernel@Vger.Kernel.ORG,
       Torvalds@Transmeta.COM
Subject: Re: [PATCH] (one line): use #ifdef with CONFIG_* 
In-Reply-To: Your message of "Tue, 22 Apr 2003 12:44:37 +0400."
             <16037.245.828642.171327@laputa.namesys.com> 
From: Valdis.Kletnieks@vt.edu
References: <16036.64756.25228.181408@laputa.namesys.com> <20030422013519.23754c14.akpm@digeo.com>
            <16037.245.828642.171327@laputa.namesys.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-713044104P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 22 Apr 2003 09:59:08 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-713044104P
Content-Type: text/plain; charset=us-ascii

On Tue, 22 Apr 2003 12:44:37 +0400, Nikita Danilov said:

> Err, I just added -Wundef to cc options and it was the only one that has
> shown up. Probably all of them should be corrected at once.

I submitted patches to clean a lot of this up, but not all seem to have
made it into Linus's kernel.  I'll re-diff against 2.5.68 and re-send.


--==_Exmh_-713044104P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+pUqrcC3lWbTT17ARAkr4AKCQIDU3kb9fYSyNGlmOOyTCGTAwVgCgnFkP
/8/YNAQ+n5/+DgihWzdz1Q0=
=IFWg
-----END PGP SIGNATURE-----

--==_Exmh_-713044104P--
