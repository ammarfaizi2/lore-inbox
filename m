Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278509AbRJ3WrY>; Tue, 30 Oct 2001 17:47:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278494AbRJ3WrF>; Tue, 30 Oct 2001 17:47:05 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:29706 "HELO holly.csn.ul.ie")
	by vger.kernel.org with SMTP id <S278509AbRJ3Wq6>;
	Tue, 30 Oct 2001 17:46:58 -0500
Date: Tue, 30 Oct 2001 22:29:33 +0000 (GMT)
From: Dave Airlie <airlied@csn.ul.ie>
X-X-Sender: <airlied@skynet>
To: <linux-kernel@vger.rutgers.edu>
Cc: <torvalds@transmeta.com>
Subject: FYI: 2.4.14-pre5 issues..
Message-ID: <Pine.LNX.4.32.0110302228010.17012-100000@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The Makefile is reporting pre4 for pre5,

and I'm seeing unresolved symbols in

loop.o
nfs.o
smbfs.o
udf.o

for free_lru_page..

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied@skynet.ie
pam_smb / Linux DecStation / Linux VAX / ILUG person



