Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263192AbUCMV1p (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 16:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263194AbUCMV1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 16:27:45 -0500
Received: from aspfw1.asp-networks.co.uk ([217.169.14.2]:29576 "HELO
	neptune.asp-networks.co.uk") by vger.kernel.org with SMTP
	id S263192AbUCMV1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 16:27:44 -0500
X-Qmail-Scanner-Mail-From: sasa@kcore.ath.cx via neptune.asp-networks.co.uk
X-Qmail-Scanner: 1.20 (Clear:RC:0(81.93.80.110):SA:0(-4.9/5.0):. Processed in 0.721695 secs)
Date: Sat, 13 Mar 2004 23:27:53 +0100
From: Sasa U <sasa@kcore.ath.cx>
To: linux-kernel@vger.kernel.org
Subject: 2.6 I/O problem ?
Message-Id: <20040313232753.63fad84e.sasa@kcore.ath.cx>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I noticed that 2.6 kernel branch, have some problem with disk read/writes.

Today I talked a little with some of my friends, and they say that they don't have that problem, and that 2.6 I/O is acctualy faster than on 2.4 kernel version.

However, I did some kind of "tests" on both, 2.4 and 2.6 kernel, with hdparm(-t,-T) and dd(disk writes), and the results is what I expected to be ... 2.4 is faster than 2.6, but, I know that is not the best way to test these kind of things, so I was wondering, is there any "offical" words on this ? Tests ?

I supose ther are more people with this kind of problem(i talked to some of them on irc.freenode.net, #kernel and some of them said that have same problem).

Kind Regards,
S
