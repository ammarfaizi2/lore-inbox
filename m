Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129392AbQKVUnd>; Wed, 22 Nov 2000 15:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129470AbQKVUnO>; Wed, 22 Nov 2000 15:43:14 -0500
Received: from laguna.tiscalinet.it ([195.130.224.86]:40414 "EHLO
        laguna.tiscalinet.it") by vger.kernel.org with ESMTP
        id <S129392AbQKVUnL>; Wed, 22 Nov 2000 15:43:11 -0500
Message-Id: <3.0.6.32.20001122211555.00abbd50@pop.tiscalinet.it>
X-Mailer: QUALCOMM Windows Eudora Light Version 3.0.6 (32)
Date: Wed, 22 Nov 2000 21:15:55 +0100
To: lm@bitmover.com
From: Lorenzo Allegrucci <lenstra@tiscalinet.it>
Subject: lmbench-2alpha12 and linux-2.4.0-test11
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It seems like lastest kernels cannot run lmbench successfully.
lmbench stops at "Local networking", between lat_connect
and bw_tcp, as far as I can see from 'top'.
No errors reported, lat_connect or bw_tcp exit silently.

All 2.4.0-test[5-11] seem to have this problem.
2.4.0-test1 and 2.2.x all run lmbench successfully instead.

--
Lorenzo
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
