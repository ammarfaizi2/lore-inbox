Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278955AbRJVV1u>; Mon, 22 Oct 2001 17:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278954AbRJVV1l>; Mon, 22 Oct 2001 17:27:41 -0400
Received: from smtp2.libero.it ([193.70.192.52]:16113 "EHLO smtp2.libero.it")
	by vger.kernel.org with ESMTP id <S278949AbRJVV1Z>;
	Mon, 22 Oct 2001 17:27:25 -0400
Message-ID: <3BD1F4B5.D8D74DBF@denise.shiny.it>
Date: Sun, 21 Oct 2001 00:03:33 +0200
From: Giuliano Pochini <pochini@denise.shiny.it>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.13-pre1 ppc)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: linuxppc-dev@lists.linuxppc.org
Subject: hfs cdrom broken in 2.4.13pre
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Kernel 2.4.13pre1 on powerpc. I can no longer mount HFS-formatted cdroms.
The last kernel I'm sure it worked fine is 2.4.7

Oct 20 23:58:51 Jay kernel: ll_rw_block: device 0b:00: only 2048-char blocks
implemented (512) 
Oct 20 23:58:51 Jay kernel: hfs_fs: unable to read block 0x00000002 from dev
0b:00 
Oct 20 23:58:51 Jay kernel: hfs_fs: Unable to read superblock 
Oct 20 23:58:51 Jay kernel: ll_rw_block: device 0b:00: only 2048-char blocks
implemented (512) 
Oct 20 23:58:51 Jay kernel: hfs_fs: unable to read block 0x00000000 from dev
0b:00 
Oct 20 23:58:51 Jay kernel: hfs_fs: Unable to read block 0. 

Bye.

