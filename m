Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130209AbRB1PJb>; Wed, 28 Feb 2001 10:09:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130208AbRB1PJV>; Wed, 28 Feb 2001 10:09:21 -0500
Received: from terra.khb.hu ([195.228.214.241]:27569 "EHLO terra.khb.hu")
	by vger.kernel.org with ESMTP id <S130206AbRB1PJM>;
	Wed, 28 Feb 2001 10:09:12 -0500
Date: Wed, 28 Feb 2001 16:07:03 +0100 (CET)
From: Holluby István holluby@interware.hu 
	<isti@interware.hu>
X-X-Sender: <isti@cica.khb.hu>
Reply-To: Holluby István <holluby@interware.hu>
To: <linux-kernel@vger.kernel.org>
Subject: mke2fs /dev/loop0
Message-ID: <Pine.LNX.4.33.0102281545120.1836-100000@cica.khb.hu>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on BPEST0/KHB/HU(Release 5.0.4 |June 8, 2000) at 02/28/2001
 04:20:24 PM,
	Serialize by Router on BPEST0/KHB/HU(Release 5.0.4 |June 8, 2000) at 02/28/2001
 04:20:25 PM,
	Serialize complete at 02/28/2001 04:20:25 PM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi!

This command hangs my system. It works for a 100K file, but it hangs my
system, if the file is 470M. It does not matter, if the disk is SCSI or
ide.

linux 2.4.2
glibc-2.2.2
gcc-2.95.2.1
e2fs-1.19

With kernel 2.2.18, it works fine.

===============
I also have some problem, with ncpfs. I am not quite sure, because I had to
hack the source, to compile it, but the same hack works with 2.2.18.


If you have anything to tell, please mail me. I am not on the list.



Holluby Istvan Budapest
(holluby@interware.hu)

