Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268096AbTBMR1e>; Thu, 13 Feb 2003 12:27:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268097AbTBMR1d>; Thu, 13 Feb 2003 12:27:33 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:8322 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S268096AbTBMR1d>; Thu, 13 Feb 2003 12:27:33 -0500
Message-Id: <200302131737.h1DHbIFT007308@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6 02/09/2003 with nmh-1.0.4+dev
To: Bruno Diniz de Paula <diniz@cs.rutgers.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to bypass buffer caches? 
In-Reply-To: Your message of "Thu, 13 Feb 2003 12:29:12 EST."
             <1045157351.21195.134.camel@urca.rutgers.edu> 
From: Valdis.Kletnieks@vt.edu
References: <1045157351.21195.134.camel@urca.rutgers.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1839908586P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 13 Feb 2003 12:37:18 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1839908586P
Content-Type: text/plain; charset=us-ascii

On Thu, 13 Feb 2003 12:29:12 EST, Bruno Diniz de Paula <diniz@cs.rutgers.edu>  said:

> the kernel. One option would be create a raw device on top of my disk
> partition, but in this case I would have to learn how to map a logical
> file name (/var/tmp/myfile) to a set of block disks. Is there any other

What's wrong with this?

     fd = open("/dev/hda7", your_flags_here);

--==_Exmh_1839908586P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+S9fNcC3lWbTT17ARAjo1AKC6vkiTMoObjLhQFjBbvk5HRoAuQQCgvO1c
koxNLNed0rfWu6ZiSuNsOgw=
=/FEf
-----END PGP SIGNATURE-----

--==_Exmh_1839908586P--
