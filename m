Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315424AbSELVWz>; Sun, 12 May 2002 17:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315425AbSELVWy>; Sun, 12 May 2002 17:22:54 -0400
Received: from albatross.mail.pas.earthlink.net ([207.217.120.120]:23947 "EHLO
	albatross.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S315424AbSELVWx>; Sun, 12 May 2002 17:22:53 -0400
Message-ID: <3CDEDEA5.2020002@earthlink.net>
Date: Sun, 12 May 2002 17:29:09 -0400
From: Becki Minich <bminich@earthlink.net>
User-Agent: Mozilla/5.0 (Windows; U; Win95; en-US; rv:0.9.4.1) Gecko/20020314 Netscape6/6.2.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Reiserfs has killed my root FS!?!
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Firstly, I haven't subscribed to this list since 2.3 so please also copy 
me on repsonses.
Secondly, I am e-mailing from my Mother's place as it IS Mother's Day 
AND my home PC will no longer boot Linux (my primary OS), so please send 
responses to johnnyo@mindspring.com
TIA :-)

Now the problem.
I use reiserfs on all my filesystems.  I have noticed some minor 
corruption of files in the past when I didnt shut down Linux properly 
(lockups, etc).  I experiment alot with my computer.

Anyway lately I was havin a problem that required frequent reboots.  Now 
I believe my root filesystem is corrupted?!?  Linux 2.4.18 boots till it 
gets to

reiserfs: checking transaction log (device 08:12)
attempt to access beyond end of device
08:12: rw=0 want=268574776 limit=8747392
vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat 
data of [1 2 0x0 SD]
Using r5 hash to sort names
Reiserfs version 3.6.25
VFS: Mounted root (reiserfs filesystem) readonly.
Warning: unable to mount devfs, err: -5
Freeing unused kernel memory: 224k freed
Warning: unable to open an initial console.
Kernel panic: No init found.

If someone can get me to the point where I can just get to read my 
filesystem read-only, so I get get all my data off of it, I would be 
EXTREMELY GRATEFUL!  I have some very important data on that FS.  I went 
to the reiserfs web site to discover I'd get charged $25 for asking for 
help, so unless someone convinces me otherwise, I will be converting to 
EXT3 when this disaster is over...

Slackware Linux 8.1b2
Linux 2.4.18
ReiserFS 3.6.25
GLIBC 2.2.5
GCC 2.95.3

Any help please?!?
John O'Donnell
johnnyo@mindspring.com


