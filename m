Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267024AbTAOTPQ>; Wed, 15 Jan 2003 14:15:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267098AbTAOTPQ>; Wed, 15 Jan 2003 14:15:16 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:40576 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S267024AbTAOTPN>; Wed, 15 Jan 2003 14:15:13 -0500
Message-Id: <200301151921.h0FJLvV0009887@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: Andrew McGregor <andrew@indranet.co.nz>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, voytech@ucw.cz,
       linux-kernel@vger.kernel.org
Subject: Re: Dell Latitude CPi keyboard problems since 2.5.42 
In-Reply-To: Your message of "Wed, 15 Jan 2003 23:43:58 +1300."
             <481480000.1042627438@localhost.localdomain> 
From: Valdis.Kletnieks@vt.edu
References: <15909.13901.284523.220804@harpo.it.uu.se>
            <481480000.1042627438@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1947896264P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 15 Jan 2003 14:21:57 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1947896264P
Content-Type: text/plain; charset=us-ascii

On Wed, 15 Jan 2003 23:43:58 +1300, Andrew McGregor said:
> Possibly related:
> 
> Dell Inspiron 8000s won't warm reboot either.  They just freeze with a 
> blinking cursor at the point where the bootloader would ordinarily load. 
> Have to power off or reset.
> 
> Consistent in various versions from 2.5.44 to .55.  Have not tested 
> earlier, nor yet later.

Dell Latitude C840s will power off.  Oddly enough, it doesn't do it when
LILO itself loads - it does it when LILO starts loading the actual kernel
image.  True from 2.5.46 through 2.5.58.
-- 
				Valdis Kletnieks
				Computer Systems Senior Engineer
				Virginia Tech


--==_Exmh_1947896264P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+JbTVcC3lWbTT17ARAv3OAJ0b+EqHZbvIIGgEm4/JyRJqHkA3fwCg5qLK
8D9E7uH/KF9rziuzf9gCYpw=
=0/Wv
-----END PGP SIGNATURE-----

--==_Exmh_1947896264P--
