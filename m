Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274887AbRIVBu5>; Fri, 21 Sep 2001 21:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274888AbRIVBuq>; Fri, 21 Sep 2001 21:50:46 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:62223 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S274887AbRIVBuf>;
	Fri, 21 Sep 2001 21:50:35 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: Announce: ksymoops 2.4.3 is available 
In-Reply-To: Your message of "Fri, 21 Sep 2001 19:09:58 +1000."
             <10723.1001063398@kao2.melbourne.sgi.com> 
Date: Sat, 22 Sep 2001 11:49:48 +1000
Message-ID: <16291.1001123388@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

Some versions of glibc define printf as a macro which prevents the use
of #ifdef inside printf.  ksymoops-2.4.3-2.src.rpm contains a work
around, no other changes were made.

ftp://ftp.<country>.kernel.org/pub/linux/utils/kernel/ksymoops/v2.4

ksymoops-2.4.3.tar.gz		Source tarball, includes RPM spec file
ksymoops-2.4.3-2.src.rpm	As above, in SRPM format
ksymoops-2.4.3-2.i386.rpm	Compiled with 2.96 20000731, glibc 2.2.2

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE7q+47i4UHNye0ZOoRAra7AKDJU+24svbg+/TlYlMX4iaxH4X89wCfTrhg
4cA6JgRySssifgUePnSw4D4=
=i1U5
-----END PGP SIGNATURE-----

