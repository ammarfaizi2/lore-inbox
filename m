Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130000AbRABRCX>; Tue, 2 Jan 2001 12:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129736AbRABRCN>; Tue, 2 Jan 2001 12:02:13 -0500
Received: from web6103.mail.yahoo.com ([128.11.22.97]:18436 "HELO
	web6103.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129523AbRABRCJ>; Tue, 2 Jan 2001 12:02:09 -0500
Message-ID: <20010102163143.12465.qmail@web6103.mail.yahoo.com>
Date: Tue, 2 Jan 2001 08:31:43 -0800 (PST)
From: Hunt Kent <kenthunt@yahoo.com>
Subject: 2.4 test10 dies every 18 or 19 days
To: lk <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	Is this a known problem? Many of the test kernels
consistently dies (hard lock up and no messages, sysrq
also dead) after 18 or 19 days. Here's my uptime
recorded with ud:

Now  : 00:11:19 running Linux 2.4.0-prerelease-c1
One  : 19 day(s), 05:40:45 running Linux
2.4.0-test8-pre1, ended Mon Sep 18 16:41:05 2000
Two  : 19 day(s), 01:26:55 running Linux 2.4.0-test10,
ended Sun Dec 31 13:01:10 2000
Three: 18 day(s), 20:46:43 running Linux 2.4.0-test8,
ended Thu Oct 12 11:50:10 2000

	Arch i386
	Dual PIII
	MB: ASUS P2BD


__________________________________________________
Do You Yahoo!?
Yahoo! Photos - Share your holiday photos online!
http://photos.yahoo.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
