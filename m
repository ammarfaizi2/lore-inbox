Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272092AbRIVUmm>; Sat, 22 Sep 2001 16:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272118AbRIVUmc>; Sat, 22 Sep 2001 16:42:32 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:6668 "HELO holly.csn.ul.ie")
	by vger.kernel.org with SMTP id <S272092AbRIVUmN>;
	Sat, 22 Sep 2001 16:42:13 -0400
Date: Sat, 22 Sep 2001 21:42:31 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: <airlied@skynet>
To: <linux-kernel@vger.kernel.org>, <linux-vax@mithra.physics.montana.edu>
Subject: Global Offset Table question..
Message-ID: <Pine.LNX.4.32.0109222139550.22558-100000@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've been trying to get dynamic loading on the Linux/VAX project going,
and I've having trouble with the Global Offset Table and how it magically
gets in to the ebx register on x86.. where is this done?

I think I've looked at the kernel, gcc, binutils, ld.so 1.9, glibc 2.2.3
and can't see exactly where this happens...

Anyone care to enlighten my poor brain...

Thanks,
	Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied@skynet.ie
pam_smb / Linux DecStation / Linux VAX / ILUG person


