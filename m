Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129051AbRAYPth>; Thu, 25 Jan 2001 10:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129169AbRAYPt1>; Thu, 25 Jan 2001 10:49:27 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:49125 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S129051AbRAYPtS>;
	Thu, 25 Jan 2001 10:49:18 -0500
Importance: Normal
Subject: question about kernel upgrade and UDF DVD
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3  March 21, 2000
Message-ID: <OFC0FC8A59.B0AE1098-ON852569DF.0054C35D@somers.hqregion.ibm.com>
From: "Jie Zhou" <jiezhou@us.ibm.com>
Date: Thu, 25 Jan 2001 10:49:06 -0500
X-MIMETrack: Serialize by Router on D02ML231/02/M/IBM(Release 5.0.6 |December 14, 2000) at
 01/25/2001 10:49:11 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am now using Red Hat 6.2, whose kernel is 2.2.14, and gcc version is
egcs-2.91.66. Now I want to upgrade the kernel to
2.3.18. In the Documentation/Changes , it's said that I need to have gcc
2.7.2.3, can i just use my current gcc without any
change?

Another requirement is about the Linux C Library on my computer. But the
command ls -l /lib/libc* doesn't show any information

Another weird thing is when I tried to see what version of Procinfo and
automount that I have, I got
 "command not found"  erro for both of them.

Finally, for the NFS, its requirement is version 2.2beta40, but I have
0.1.6, how can I upgrade it?

BTW, Is there any one who's already got the UDF format DVD installed on
your Linux system?

Thanks. And happy lunar new year to everyone!
-Jie


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
