Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270135AbRH1CGp>; Mon, 27 Aug 2001 22:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270155AbRH1CGf>; Mon, 27 Aug 2001 22:06:35 -0400
Received: from papperstuss.flashdance.cx ([213.80.64.40]:30482 "EHLO
	papperstuss.flashdance.cx") by vger.kernel.org with ESMTP
	id <S270135AbRH1CGX>; Mon, 27 Aug 2001 22:06:23 -0400
Date: Tue, 28 Aug 2001 04:06:48 +0200 (CEST)
From: Peter Magnusson <iocc@flashdancejahatjosan.cx>
X-X-Sender: <iocc@papperstuss.flashdance.cx>
To: <linux-kernel@vger.kernel.org>
Subject: VM balancing stuff in 2.4.8-9 broken
Message-ID: <Pine.LNX.4.33L2.0108280403140.1540-100000@papperstuss.flashdance.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just wanted to say that the VM balancing stuff in 2.4.8 and 2.4.9 doesnt
work very well. 2.4.8 and .9 will use 200 Mbyte of my swap after just 6
hours! I got 512 Mbyte RAM, 256 Mbyte swap.

I have now switched back to 2.4.7. Uptime 6 days and 11 Mbyte swap used.
I would prefer if Linux used as little swap as possible. It only gets
slower.

(if you want to reply to me send mail to iocc@flashdancejahatjosan.cx
without jahatjosan.)


