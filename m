Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263249AbTEINEq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 09:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263271AbTEINEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 09:04:45 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:384 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263249AbTEINEp (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 09:04:45 -0400
Message-Id: <200305090520.h495K9xH001928@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Dave Zarzycki <dave@zarzycki.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI-X/Ultra320/RAID tuning problem? 
In-Reply-To: Your message of "Thu, 08 May 2003 00:12:36 PDT."
             <Pine.OSX.4.44.0305071941490.2203-100000@rikku.zarzycki.org> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.OSX.4.44.0305071941490.2203-100000@rikku.zarzycki.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_74367054P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 09 May 2003 01:20:09 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_74367054P
Content-Type: text/plain; charset=us-ascii

On Thu, 08 May 2003 00:12:36 PDT, Dave Zarzycki <dave@zarzycki.org>  said:
> I seem to be topping out at 200 to 255MB/s depending on the setup
> (messured with hdparm -t and dd), while each drive is capable of 72MB/s.
> Dual Ultra320 with PCI-X should do better than this, right? I'd estimate
> 500+ MB/s given this setup. Am I being unreasonable?

What's the backplane/whatever max effective bandwidth?


--==_Exmh_74367054P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+uzqJcC3lWbTT17ARAum2AJ46Qfq25JJGzLiKPoeZXnivpWBVHgCgnaPn
db+EaE2OHQrO+0JgpkXUt2o=
=bqjk
-----END PGP SIGNATURE-----

--==_Exmh_74367054P--
