Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289310AbSAVOGm>; Tue, 22 Jan 2002 09:06:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289311AbSAVOGc>; Tue, 22 Jan 2002 09:06:32 -0500
Received: from web14905.mail.yahoo.com ([216.136.225.57]:26380 "HELO
	web14905.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S289310AbSAVOGO>; Tue, 22 Jan 2002 09:06:14 -0500
Message-ID: <20020122140613.51122.qmail@web14905.mail.yahoo.com>
Date: Tue, 22 Jan 2002 09:06:13 -0500 (EST)
From: Michael Zhu <mylinuxk@yahoo.ca>
Subject: something about ext2 file system
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, I have some questions about ext2 file system.

1.How the directory and file name information are
stored on the disk? I mean is there a range of blocks
set at disk format or intialize time for this kind of
information?

2.I know in ext2 the whole disk is made up of the boot
block and some block groups. Each block groups
contains super block,group descriptors,data block
bitmap,inode bitmap,inode table and data blocks. The
directory and file name information are stored in
which part? In the data blocks?

3.Are file names and other metadata put into the same
range of blocks?

4.Where can I find some detail information about ext2
fiel system?

Thanks in advance.

Michael


______________________________________________________________________ 
Web-hosting solutions for home and business! http://website.yahoo.ca
