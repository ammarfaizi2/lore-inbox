Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135617AbRDXNmT>; Tue, 24 Apr 2001 09:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135619AbRDXNl6>; Tue, 24 Apr 2001 09:41:58 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:40206 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S135610AbRDXNjc>; Tue, 24 Apr 2001 09:39:32 -0400
Date: Tue, 24 Apr 2001 15:39:07 +0200 (CEST)
From: Axel Siebenwirth <axel@rayfun.org>
To: linux-kernel@vger.kernel.org
cc: linux-net@vger.kernel.org, realtek@scyld.com
Subject: dirty entry in transmit queue on eth (fwd)
Message-ID: <Pine.LNX.4.21.0104241538080.9290-100000@neon.rayfun.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sorry, my email address was wrong, it's axel@rayfun.org

---------- Forwarded message ----------
Date: Tue, 24 Apr 2001 15:36:12 +0200 (CEST)
From: Axel Siebenwirth <axel@neon.rayfun.org>
To: linux-kernel@vger.kernel.org
Cc: linux-net@vger.kernel.org, realtek@scyld.com
Subject: dirty entry in transmit queue on eth

oh please could someone tell me what this is supposed to mean and/or where
this might be originating from. it's a realtek 8139 and im running linux
kernel 2.4.4pre3.

Apr 24 15:24:29 bello kernel: eth1: Setting half-duplex based on
auto-negotiated partner ability 0000.
Apr 24 15:24:41 bello kernel: NETDEV WATCHDOG: eth1: transmit timed out
Apr 24 15:24:41 bello kernel: eth1: Tx queue start entry 523  dirty entry
519.
Apr 24 15:24:41 bello kernel: eth1:  Tx descriptor 0 is 00002000.
Apr 24 15:24:41 bello kernel: eth1:  Tx descriptor 1 is 00002000.
Apr 24 15:24:41 bello kernel: eth1:  Tx descriptor 2 is 00002000.
Apr 24 15:24:41 bello kernel: eth1:  Tx descriptor 3 is 00002000. (queue
head)

thank you, i have posted this/my problem almost everywhere but havent
got one respone yet.

Axel Siebenwirth


