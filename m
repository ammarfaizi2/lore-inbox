Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268546AbRHBBNX>; Wed, 1 Aug 2001 21:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268444AbRHBBNN>; Wed, 1 Aug 2001 21:13:13 -0400
Received: from ffke-campus-gw.mipt.ru ([194.85.82.65]:19328 "EHLO
	www.2ka.mipt.ru") by vger.kernel.org with ESMTP id <S268358AbRHBBNG>;
	Wed, 1 Aug 2001 21:13:06 -0400
Message-Id: <200108020112.f721CRZ01814@www.2ka.mipt.ru>
Date: Thu, 2 Aug 2001 06:14:56 +0400
From: John Polyakov <johnpol@2ka.mipt.ru>
To: linux-kernel@vger.kernel.org
Subject: Ununderstanding network messages.
Reply-To: johnpol@2ka.mipt.ru
X-Mailer: stuphead ver. 0.5.3 (Wiskas) (GTK+ 1.2.7; Linux 2.4.7-ac1; i686)
Organization: MIPT
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

After running a simple networking programm( which only generates a large
number of packets), some messages became to appears:
NET: 6 messages suppressed.
ip_conntrack: table full, dropping packet.
.... and so many, many times ....

I somewhat understand, what this messages means.
I think, packets queue is filled at all, and new packets are simply
dropped.

I'm i right, and does this behavior correct?

I have kernel 2.4.7-ac1 and 10Mb lan( which actuall speed is much less :( ).
I have Net-tools              1.55.
Ethernet adapter is NE2k-pci and compiled into the kernel.

Thanks in advance for advices and help.
---
WBR. //s0mbre
