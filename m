Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262794AbTELWWE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 18:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262842AbTELWWD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 18:22:03 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:22920 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262794AbTELWWA (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 18:22:00 -0400
Message-Id: <200305122229.h4CMTqJ5032241@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: The disappearing sys_call_table export. 
In-Reply-To: Your message of "Mon, 12 May 2003 22:19:51 BST."
             <1052774389.31825.21.camel@dhcp22.swansea.linux.org.uk> 
From: Valdis.Kletnieks@vt.edu
References: <200305121754_MC3-1-388D-BC60@compuserve.com> <200305122212.h4CMCDJ5031682@turing-police.cc.vt.edu>
            <1052774389.31825.21.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1753501222P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 12 May 2003 18:29:52 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1753501222P
Content-Type: text/plain; charset=us-ascii

On Mon, 12 May 2003 22:19:51 BST, Alan Cox said:

> 1. Base Linux is not C2 certified
> 2. C2 is obsolete

Right.. but the point was that the object-reuse stuff was known 20 years ago
to have to be inside the TCB....  And in the Linux world, having /etc/rc?.d/
and all the dependent code inside the TCB is just... ugly.. ;)

--==_Exmh_-1753501222P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+wCBfcC3lWbTT17ARAnSqAKC/4NadCUMKhmaRiEhZBZzBhc5nggCfYbva
hu2PEnh1/j7M0gsu305rhnE=
=iXiR
-----END PGP SIGNATURE-----

--==_Exmh_-1753501222P--
