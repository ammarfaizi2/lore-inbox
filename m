Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129098AbQKFPm3>; Mon, 6 Nov 2000 10:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129123AbQKFPmU>; Mon, 6 Nov 2000 10:42:20 -0500
Received: from mercury.eng.emc.com ([168.159.40.77]:15112 "EHLO
	mercury.lss.emc.com") by vger.kernel.org with ESMTP
	id <S129098AbQKFPmN>; Mon, 6 Nov 2000 10:42:13 -0500
Message-ID: <276737EB1EC5D311AB950090273BEFDD979E00@elway.lss.emc.com>
From: "chen, xiangping" <chen_xiangping@emc.com>
To: linux-kernel@vger.kernel.org
Subject: Clock problem in Linux 2.4.0-test1 SMP?
Date: Mon, 6 Nov 2000 10:36:04 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Recently when I tried to test disk IO of a dual-processor PC
using linux 2.4.0-test1 SMP, I found that the clock slows down.
Could somebody tell me why it happened, and is there any patch 
for this problem?

BTW, is there any good tool to measure disk IO, like "iostat"
on Solaris?

Thanks!

Xiangping
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
