Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289551AbSBST2Y>; Tue, 19 Feb 2002 14:28:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289347AbSBST2P>; Tue, 19 Feb 2002 14:28:15 -0500
Received: from mailsorter.ma.tmpw.net ([63.112.169.25]:25891 "EHLO
	mailsorter.ma.tmpw.net") by vger.kernel.org with ESMTP
	id <S289339AbSBST2E>; Tue, 19 Feb 2002 14:28:04 -0500
Message-ID: <3AB544CBBBE7BF428DA7DBEA1B85C79C01101F40@nocmail.ma.tmpw.net>
From: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: lvm will not compile on 2.5.5pre1
Date: Tue, 19 Feb 2002 14:27:58 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can someone point me in the right direction.  I am scanning the code, but
not sure where to follow up with this.  LVM won't compile in 2.5.5pre1, I
get the following error upon compilation.
                                                        
lvm.c: In function `lvm_do_lock_lvm':

lvm.c:1310: structure has no member named `sigpending'  

I'm looking into why this is, but can't seem to find where the structure is
located to fix it, and what member may be missing.  Any help or pointers
appreciated.

Thanks,
Bruce H.
 
