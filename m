Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263086AbREaM20>; Thu, 31 May 2001 08:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263088AbREaM2P>; Thu, 31 May 2001 08:28:15 -0400
Received: from oceanic.wsisiz.edu.pl ([213.135.44.33]:63248 "HELO
	oceanic.wsisiz.edu.pl") by vger.kernel.org with SMTP
	id <S263086AbREaM2D>; Thu, 31 May 2001 08:28:03 -0400
Date: Thu, 31 May 2001 14:27:26 +0200 (CEST)
From: Lukasz Trabinski <lukasz@wsisiz.edu.pl>
To: <linux-kernel@vger.kernel.org>
Subject: reiserfs_read_inode2
Message-ID: <Pine.LNX.4.33.0105311425110.21274-100000@oceanic.wsisiz.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

What it's means?

portraits:~# dmesg
vs-13042: reiserfs_read_inode2: [2299 593873 0x0 SD] not found
vs-13048: reiserfs_iget: bad_inode. Stat data of (2299 593873) not found
vs-13042: reiserfs_read_inode2: [2299 593807 0x0 SD] not found
vs-13048: reiserfs_iget: bad_inode. Stat data of (2299 593807) not found

2.4.5 with lock_kernel/unlock patch,reiserfsprogs 3.x.0h, RH 7.1

-- 
*[ £ukasz Tr±biñski ]*
SysAdmin @wsisiz.edu.pl

