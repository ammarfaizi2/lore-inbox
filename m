Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287161AbRL2I2Y>; Sat, 29 Dec 2001 03:28:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287163AbRL2I2O>; Sat, 29 Dec 2001 03:28:14 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:52754 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S287161AbRL2I2G>;
	Sat, 29 Dec 2001 03:28:06 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: kbuild-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, Release 1.12 is available 
In-Reply-To: Your message of "Fri, 28 Dec 2001 13:31:42 +1100."
             <19466.1009506702@ocs3.intra.ocs.com.au> 
Date: Sat, 29 Dec 2001 19:27:51 +1100
Message-ID: <10706.1009614471@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

On Fri, 28 Dec 2001 13:31:42 +1100, 
Keith Owens <kaos@ocs.com.au> wrote:
>This announcement is for the base kbuild 2.5 code, i386 against 2.4.16.
>Patches for other architectures and kernels will be out later today, it
>takes time to generate and test patches for 6 architectures against 3
>different kernel trees.

All architecture and tree specific patches for kbuild 2.5 are now
available, if you don't see your arch then nobody has sent me a patch
yet.

kbuild-2.5-2.4.16-3		Base code and i386.  Use this patch for
				2.5.0 as well.
kbuild-2.5-2.4.17-1		From 2.4.16 to 2.4.17.
kbuild-2.5-2.4.18-pre1-1	From 2.4.17 to 2.4.18-pre1.
kbuild-2.5-2.5.1-1		From 2.4.16 (2.5.0) to 2.5.1.
kbuild-2.5-2.5.2-pre3-1		From 2.5.1 to 2.5.2-pre3.

kbuild-2.5-2.4.16-alpha-1	Add on for alpha by Ghozlane Toumi.
kbuild-2.5-2.4.16-ppc-1		Add on for ppc by Tom Rini.
kbuild-2.5-2.4.17-ia64-011226-1	Add on for ia64-011226, only for 2.4.17.
kbuild-2.5-2.4.16-sparc32-2	Add on for sparc32, Ben Collins, Keith Owens.
kbuild-2.5-2.4.16-sparc64-2	Add on for sparc64, Ben Collins, Keith Owens.

Everybody needs kbuild-2.5-2.4.16-3.  Fetch the other patches if you
want other kernels or architectures.

Alpha and PPC do not have CML2 support yet, everything else has CML2
support.  PPC does not have bzImage support yet.

- ---
One script to rule them all, One script to find them,
One script to bring them all and in the darkness build them.
In the land of Linux, using shadow trees.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE8LX6Di4UHNye0ZOoRAk8gAKC8dGevkBebzYSgM1abvTEh3HyxIACgttJH
a1gwFid6KpDBTH7kGmZ1kf0=
=OCPO
-----END PGP SIGNATURE-----

