Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266503AbUBDUYp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 15:24:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266502AbUBDUWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 15:22:12 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:59267 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S266490AbUBDUVb (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 15:21:31 -0500
Message-Id: <200402042021.i14KLT3d011076@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: "Randazzo, Michael" <RANDAZZO@ddc-web.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.x POSIX Compliance/Conformance... 
In-Reply-To: Your message of "Wed, 04 Feb 2004 15:18:17 EST."
             <89760D3F308BD41183B000508BAFAC4104B16F38@DDCNYNTD> 
From: Valdis.Kletnieks@vt.edu
References: <89760D3F308BD41183B000508BAFAC4104B16F38@DDCNYNTD>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1178359035P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 04 Feb 2004 15:21:29 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1178359035P
Content-Type: text/plain; charset=us-ascii

On Wed, 04 Feb 2004 15:18:17 EST, "Randazzo, Michael" said:
> Where are the kernel calls defined for locks and semaphores?
> 
> How come the kernel headers don't define Posix.4 
> semaphores (_POSIX_SEMAPHROES) or Posix itself
> (_POSIX_VERSION is undefined)

Posix.4 and _POSIX_VERSION are for *userspace*

The kernel isn't userspace.

--==_Exmh_1178359035P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAIVRJcC3lWbTT17ARAulvAKDWJsTvCRJaoWWZyuF9Oeathb+xcQCgyoFe
8fcquWi1y73KkPGIhl/kmkY=
=P+67
-----END PGP SIGNATURE-----

--==_Exmh_1178359035P--
