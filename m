Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313943AbSDZNBf>; Fri, 26 Apr 2002 09:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313988AbSDZNBe>; Fri, 26 Apr 2002 09:01:34 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:43798 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S313943AbSDZNBd>; Fri, 26 Apr 2002 09:01:33 -0400
Subject: [BK-Patch-2.5.10] NTFS 2.0.3 submission for kernel inclusion
From: Anton Altaparmakov <aia21@cantab.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 26 Apr 2002 14:01:30 +0100
Message-Id: <1019826090.28441.7.camel@storm.christs.cam.ac.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Following my submission of NTFS 2.0.2 Andrew Morton emailed me with a
list of minor issues he found when reviewing the code. So I have updated
NTFS to 2.0.3, fixing all reported bugs as well as applying an
optimisation I had planned for a while and throwing out some dead code
out. The result has been stress tested for over an hour and was fine.

It would be great if you would do a bk pull from the ntfs tng bkbits
repository:

        bk://linux-ntfs.bkbits.net/ntfs-tng-2.5

If you would prefer a bitkeeper patch inline with an email, please let
me know and I will generate one and email it to you ASAP...

ps. For all non-bitkeeper users, normal diff -urNp patches for 2.5.10
vanilla as well as an incremental patch from 2.5.10+ntfs-2.0.2 to
ntfs-2.0.3 are available from Sourceforge:

	http://linux-ntfs.sf.net/downloads.html

Best regards,

        Anton

-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ &
http://www-stu.christs.cam.ac.uk/~aia21/
