Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314443AbSD0UDW>; Sat, 27 Apr 2002 16:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314444AbSD0UDV>; Sat, 27 Apr 2002 16:03:21 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:25157 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S314443AbSD0UDQ>; Sat, 27 Apr 2002 16:03:16 -0400
Subject: [BK-2.5.11] NTFS 2.0.4 submission for kernel inclusion
From: Anton Altaparmakov <aia21@cantab.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 27 Apr 2002 21:03:14 +0100
Message-Id: <1019937794.28694.23.camel@storm.christs.cam.ac.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

I've updated NTFS to work with the current linus-2.5 BK tree containing
Al's cleanups. I also added to Documentation/filesystems/ntfs.txt how to
use the MD driver to make ntfs stripe and volume sets work under Linux.

It would be great if you would do a bk pull from the ntfs tng bkbits
repository:

        bk://linux-ntfs.bkbits.net/ntfs-tng-2.5

If you would prefer a bitkeeper patch inline with an email, please let
me know and I will generate one and email it to you ASAP...

Best regards,

        Anton

ps. For all non-bitkeeper users, I will make normal diff -urNp patches
available once 2.5.11 is released on ftp.??.kernel.org. For now, you
can browse the code on-line:
	http://linux-ntfs.bkbits.net:8080/ntfs-tng-2.5

-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ &
http://www-stu.christs.cam.ac.uk/~aia21/
