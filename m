Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132413AbRDMXih>; Fri, 13 Apr 2001 19:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132414AbRDMXi1>; Fri, 13 Apr 2001 19:38:27 -0400
Received: from shuzbut.anathoth.gen.nz ([202.36.174.50]:3080 "EHLO
	shuzbut.anathoth.gen.nz") by vger.kernel.org with ESMTP
	id <S132413AbRDMXiN>; Fri, 13 Apr 2001 19:38:13 -0400
X-Mailer: exmh version 2.2 06/23/2000 (debian 2.2-1) with nmh-1.0.2
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: grantma@anathoth.gen.nz (Matthew Grant), linux-kernel@vger.kernel.org
Subject: Re: New SYM53C8XX driver in 2.4.3-ac5 FIXES CD Writing!!!! 
In-Reply-To: Message from Alan Cox <alan@lxorguk.ukuu.org.uk> 
   of "Sat, 14 Apr 2001 00:28:05 +0100." <E14oCz2-0003nA-00@the-village.bc.nu> 
In-Reply-To: <E14oCz2-0003nA-00@the-village.bc.nu> 
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1108435722P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 14 Apr 2001 11:37:43 +1200
From: Matthew Grant <grantma@anathoth.gen.nz>
Message-Id: <E14oD8K-0002oj-00@zion.int.anathoth.gen.nz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1108435722P
Content-Type: text/plain; charset=us-ascii

Dear All!!

A core kernel developer  NEEDS to get these features straightened out properly 
in a clean fashion.  People WANT reiserfs integrated and working with LVM and 
RAID,  with good quota support.  These are 'Enterpise' level features.

It does not look like that much work is needed to fix the stuff the base kernel
and get better integration of these features.  The rough edges on them make us 
look like a bunch of amatuers.

Alan, will you look into it as a project???

Best Regards,

Matthew Grant

> > kernel is more broken than beta7  version, a lot of lvm operations in the 
> > kernel version DON'T WORK!!!
> 
> beta7 is also broken
> 
> > What are the problems????
> 
> Disgusting stuff like using the low 2bits of an address as flags.
> 
> > Reiserfs quota support should be added to the kernel if it is simple also.  
> 
> its not worth doing. Thats based on the current, racey, broken quota code
> not the -ac quota code we need
> 
> > there rather than having a lot of different ongoing backroom operations to add 
> > the functionality.
> 
> For the base kernel they need to work properly. Vendors may be less picky.

-- 
===============================================================================
Matthew Grant	     /\	 ^/\^	grantma@anathoth.gen.nz  It's/~~~~\Plain where
A Linux Network Guy /~~\^/~~\_/~~~~~\_______/~~~~~~~~~~\____/******\I come from
===============================================================================



--==_Exmh_1108435722P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: Exmh version 2.2 06/23/2000 (debian 2.2-1)

iD8DBQE6143Huk55Di7iAnARApuoAKCkvwSLupJ8WhyU1my2ayyu4hF1igCbB+n6
rPgjtAflgmUFdf+xI1iCQjs=
=y8T6
-----END PGP SIGNATURE-----

--==_Exmh_1108435722P--
