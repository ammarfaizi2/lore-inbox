Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129854AbQKHWGc>; Wed, 8 Nov 2000 17:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130067AbQKHWGW>; Wed, 8 Nov 2000 17:06:22 -0500
Received: from denise.shiny.it ([194.20.232.1]:62222 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id <S129854AbQKHWGM>;
	Wed, 8 Nov 2000 17:06:12 -0500
Message-ID: <3A0A2141.E3EC14FF@denise.shiny.it>
Date: Wed, 08 Nov 2000 23:00:01 -0500
From: Giuliano Pochini <pochini@denise.shiny.it>
X-Mailer: Mozilla 4.6 [en] (X11; I; Linux 2.2.18pre19 ppc)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Ethernet stops working in NFS
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a Mac and a PC with a 3com 595 ethernet card. The Mac is the
nfs server. When I transfer from the PC to the Mac it's all right.
When I transfer a large file (50-100MB) from the Mac to the PC often
the connection breaks completely. I can't ping the other machine
anymore. Looking at ifconfig I see that the PC receives the pings
but it does not answer. I have to bring the PC's eth0 down and up
to get it working again. Large ping floods don't trigger the
problem.
And is it normal that I transfer at only ~5MB/s over a 100Mbps
ethernet ?

The PC runs 2.2.17 and the Mac 2.2.18pre19.

Bye.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
