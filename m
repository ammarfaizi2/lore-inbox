Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266330AbTAJTPR>; Fri, 10 Jan 2003 14:15:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266310AbTAJTPQ>; Fri, 10 Jan 2003 14:15:16 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:10113 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S266297AbTAJTPK>; Fri, 10 Jan 2003 14:15:10 -0500
Message-Id: <200301101921.h0AJLFLK012541@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: Manish Lachwani <m_lachwani@yahoo.com>
Cc: linux-kernel@vger.kernel.org, Michael.Knigge@set-software.de
Subject: Re: FW: Fastest possible UDMA - how? 
In-Reply-To: Your message of "Fri, 10 Jan 2003 11:04:03 PST."
             <20030110190403.2127.qmail@web20510.mail.yahoo.com> 
From: Valdis.Kletnieks@vt.edu
References: <20030110190403.2127.qmail@web20510.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-225802426P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 10 Jan 2003 14:20:34 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-225802426P
Content-Type: text/plain; charset=us-ascii

On Fri, 10 Jan 2003 11:04:03 PST, Manish Lachwani <m_lachwani@yahoo.com>  said:
> Take a look at the drive IDENTIFY data. From the ATA
> spec, it can be seen that word# 88 in the IDENTIFY
> data can help you find out the UDMA mode selected and
> UDMA mode supported. 
> 
> The UDMA mode supported is the maximum supported by
> the drive. 

Will this DTRT if the IDE *controller* does UDMA-5 but the drives are UDMA-2
at best?

--==_Exmh_-225802426P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+Hx0CcC3lWbTT17ARAsHzAJ4tsaZn3Q23EdI+Yt2qG5UKgPLyHgCfY1WK
jsZZpd56L49J3VyxcXywMAM=
=47CP
-----END PGP SIGNATURE-----

--==_Exmh_-225802426P--
