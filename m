Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268140AbRHKQIg>; Sat, 11 Aug 2001 12:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268434AbRHKQI0>; Sat, 11 Aug 2001 12:08:26 -0400
Received: from pc2-camb6-0-cust223.cam.cable.ntl.com ([213.107.107.223]:49541
	"EHLO kings-cross.london.uk.eu.org") by vger.kernel.org with ESMTP
	id <S268140AbRHKQIR>; Sat, 11 Aug 2001 12:08:17 -0400
X-Mailer: exmh version 2.3.1 01/18/2001 (debian 2.3.1-1) with nmh-1.0.4+dev
To: Russell King <rmk@arm.linux.org.uk>
Cc: Keith Owens <kaos@ocs.com.au>, kbuild-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, Release 1.1 is available. 
In-Reply-To: Message from Russell King <rmk@arm.linux.org.uk> 
   of "Sat, 11 Aug 2001 16:20:28 BST." <20010811162028.A2732@flint.arm.linux.org.uk> 
In-Reply-To: <1904.997542180@ocs3.ocs-net>  <20010811162028.A2732@flint.arm.linux.org.uk> 
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1641692016P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 11 Aug 2001 17:08:08 +0100
From: Philip Blundell <philb@gnu.org>
Message-Id: <E15VbJ2-0000y8-00@kings-cross.london.uk.eu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1641692016P
Content-Type: text/plain; charset=us-ascii

>I'm sorry, the ARM version of GCC does not support %c0 in a working
>state.  The way we generate the offsets on ARM is here to stay for
>the next few years until GCC 3 has stabilised well enough for use
>with the kernel, and the ARM architecture specifically.

I should think it can be made to work in 2.95.4.  Did you try the patch I sent 
you a few months ago?

p.


--==_Exmh_-1641692016P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.5 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999 (debian)

iD8DBQE7dVhoVTLPJe9CT30RAgR4AKDNW7IKm+i1vogXgRLOF7YVA9pjFwCffHq5
IT5Cxtpn9TQXjssfwFmJN4Q=
=Wxml
-----END PGP SIGNATURE-----

--==_Exmh_-1641692016P--
