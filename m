Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132807AbQLNU1j>; Thu, 14 Dec 2000 15:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132868AbQLNU13>; Thu, 14 Dec 2000 15:27:29 -0500
Received: from tomts5.bellnexxia.net ([209.226.175.25]:3502 "EHLO
	tomts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S132807AbQLNU1W>; Thu, 14 Dec 2000 15:27:22 -0500
From: Gerard Beekmans <gerard@linuxfromscratch.org>
Organization: LFS
Date: Thu, 14 Dec 2000 14:55:59 -0500
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.0-test11/12 freezes when copying large amounts of data to loop file system
MIME-Version: 1.0
Message-Id: <00121414555900.00305@gwaihir>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Every time I try to copy a specific directory to a mounted loop file system, 
Linux freezes up on me. I've tried this several times and it freezes up at 
the same place every time. When I copy that same directory to a regular file 
system everything is ok.

This happens on 2.4.0 test11 and test12 kernels. I've tried a test8 kernel 
previously and it didn't have this problem. Is this a known issue and if so, 
is there a patch available somewhere?

PS: as im not on this list please CC a reply to me.

Thanks,

-- 
Gerard Beekmans
www.linuxfromscratch.org

-*- If Linux doesn't have the solution, you have the wrong problem -*-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
