Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274194AbRJJCWb>; Tue, 9 Oct 2001 22:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274234AbRJJCWV>; Tue, 9 Oct 2001 22:22:21 -0400
Received: from rj.sgi.com ([204.94.215.100]:23224 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S274194AbRJJCWC>;
	Tue, 9 Oct 2001 22:22:02 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@melbourne.sgi.com>
To: kdb@oss.sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: Announce: kdb v1.9 is available for kernel 2.4.11
Date: Wed, 10 Oct 2001 12:21:23 +1000
Message-ID: <8727.1002680483@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

ftp://oss.sgi.com/projects/kdb/download/ix86/kdb-v1.9-2.4.11.bz2

The disassembler related files bfd.h and ansidecl.h have been copied
into the kdb patch, in arch/$(ARCH)/kdb.  This removes any dependency
on user space includes for kdb.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE7w7Cii4UHNye0ZOoRAqslAKCuqQ3gncncPXPO4UnUnnCNEcbuAgCePT+h
7fB03Ec/IvNtU8MnKXefWHg=
=qwYK
-----END PGP SIGNATURE-----

