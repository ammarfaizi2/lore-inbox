Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130423AbRADQSp>; Thu, 4 Jan 2001 11:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131125AbRADQSf>; Thu, 4 Jan 2001 11:18:35 -0500
Received: from [202.52.231.194] ([202.52.231.194]:5418 "EHLO healthnet.org.np")
	by vger.kernel.org with ESMTP id <S130423AbRADQSa>;
	Thu, 4 Jan 2001 11:18:30 -0500
From: mpradhan@healthnet.org.np
To: linux-kernel@vger.kernel.org
Date: Thu, 4 Jan 2001 22:27:09 +0530
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Compilation error in Red Hat 6.2
Message-ID: <3A54F8BD.14576.3D66AD@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear users,


I am getting one error while compiling kernal in Red Hat 6.2:  
VFS: cannot open root device 08:01 > Kernel panic: VFS: 
unable to mount root fs on 08:01 >
 I have used make bzImage to make the 
new image after make dep; > make clean.

With regards,

Sincerely yours,

Mohan Raj Pradhan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
