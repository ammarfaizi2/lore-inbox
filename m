Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272611AbRHaFyK>; Fri, 31 Aug 2001 01:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272612AbRHaFx7>; Fri, 31 Aug 2001 01:53:59 -0400
Received: from rj.sgi.com ([204.94.215.100]:25744 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S272611AbRHaFxu>;
	Fri, 31 Aug 2001 01:53:50 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: kbuild-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Announce: Kernel Build for 2.5, Release 1.2 is available.
Date: Fri, 31 Aug 2001 15:53:45 +1000
Message-ID: <11953.999237225@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

Release 1.2 of kernel build for kernel 2.5 (kbuild 2.5) is available.
http://sourceforge.net/projects/kbuild/, Package kbuild-2.5, download
release 1.2.

http://marc.theaimsgroup.com/?l=linux-kernel&m=99725412902968&w=2
contains information about the base release.

Changes from Release 1.1

  Add several commands:

    base_target() - allow for multiple targets, not just vmlinux.  This
    allows the kbuild commands to be used for the boot loader as well
    as the kernel.

    hostcc(), hostld(), hostccld() - Better method of compiling
    programs to run on the host, including full dependency tracking.

    setup() - Last ditch option when nothing else will work, generate
    setup files right at the start.

  Sync with kernel 2.4.9.

  More documentation.  As always, Documentation/kbuild/kbuild-2.5.txt
  is your friend.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.3 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE7jyZoi4UHNye0ZOoRAjAZAKC5pm6bOTroeHdCb2lZDrLfQxslQwCfV5pV
nSRuma9A/1DCs5UIS1T8liY=
=zXNM
-----END PGP SIGNATURE-----

