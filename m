Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263377AbSJ3EXh>; Tue, 29 Oct 2002 23:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263589AbSJ3EXh>; Tue, 29 Oct 2002 23:23:37 -0500
Received: from lan-202-144-95-57.maa.sify.net ([202.144.95.57]:38919 "EHLO
	nisserver.cosystems.com") by vger.kernel.org with ESMTP
	id <S263377AbSJ3EXg>; Tue, 29 Oct 2002 23:23:36 -0500
From: "Harish Kulkarni" <hari@cosystech.com>
To: <linux-kernel@vger.kernel.org>
Subject: Network Device Driver Help Required
Date: Tue, 29 Oct 2002 20:17:59 +0530
Message-ID: <NFBBKDONILLOCGDCFLLICELCCFAA.hari@cosystech.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-Mimeole: Produced By Microsoft MimeOLE V5.00.2615.200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,
I have worked on PCI-Device driver on Linux 2.4.18-3 (i386), at presently i
am working on a T1/E1 device driver development.
The following are the questions i have:

 How one n/w layer will interact with other n/w layer ( driver)
	e.g. in my case T1/E1 driver will interface with Lapd, i have found skbuffs
utilization for
	doing the same. I am not clear on the same?. How skbuffs can be used. ( if
possible please provide/suggest me with a piece of
	demo code which can be handy to understand "skbuffs" concepts.

 Can i have any other interface for applications other then sockets?

 Can any one suggest me any documents/articles to read, i have Rubini's
"Linux Device Drivers".

-Thanks in advance.
Hari

