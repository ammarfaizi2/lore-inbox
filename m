Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129229AbQJ3LPe>; Mon, 30 Oct 2000 06:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129244AbQJ3LPZ>; Mon, 30 Oct 2000 06:15:25 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:23815 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S129229AbQJ3LPP>; Mon, 30 Oct 2000 06:15:15 -0500
Message-Id: <200010301115.MAA10601@magma.cs.uni-dortmund.de>
Date: Mon, 30 Oct 2000 12:15:13 +0100 (MET)
From: Christoph Pleger <pleger@carmin.cs.uni-dortmund.de>
Reply-To: Christoph Pleger <pleger@carmin.cs.uni-dortmund.de>
Subject: FIFO-Scheduling in Kernel 2.2
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Content-MD5: ZwO/m2HIn59zfzkMTK3+rw==
X-Mailer: dtmail 1.2.1 CDE Version 1.2.1 SunOS 5.6 sun4m sparc 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I experienced problems in programs which used priorities under FIFO-Scheduling 
with Kernel 2.2 although these programs worked well with Kernel 2.0. 

I read in this list that other people had the same problems.

Is any solution (a newer kernel version or a special patch) available for that
problem?

Christoph

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
