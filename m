Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132567AbRDAVe1>; Sun, 1 Apr 2001 17:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132568AbRDAVeR>; Sun, 1 Apr 2001 17:34:17 -0400
Received: from portraits.wsisiz.edu.pl ([195.205.208.34]:580 "EHLO
	portraits.wsisiz.edu.pl") by vger.kernel.org with ESMTP
	id <S132567AbRDAVeM>; Sun, 1 Apr 2001 17:34:12 -0400
Date: Sun, 1 Apr 2001 23:32:14 +0200 (CEST)
From: Lukasz Trabinski <lukasz@lt.wsisiz.edu.pl>
To: <linux-kernel@vger.kernel.org>
Subject: EXT2-fs error on 2.4.2 & 2.4.3
Message-ID: <Pine.LNX.4.33.0104012319090.1361-100000@lt.wsisiz.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I'm using 2.4.2 and 2.4.3, sometimes after cron jobs like slocate process
or checking md5sum on my file system(heavy load disk), i gets errors from
the kernel:

EXT2-fs error (device sd(8,3)): ext2_free_blocks: bit already cleared for
block
80275
EXT2-fs error (device sd(8,3)): ext2_free_blocks: bit already cleared for
block
80275
EXT2-fs error (device sd(8,3)): ext2_free_blocks: bit already cleared for
block
80275
[...]

This problems occurs on THREE machines (with heavy load disks) with
kernel 2.4.2[3] and I dont't  think that is a problems with disks or RAM.
Any idea?


-- 
*[ £ukasz Tr±biñski ]*
SysAdmin @wsisiz.edu.pl

