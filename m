Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267582AbRGSPLl>; Thu, 19 Jul 2001 11:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267584AbRGSPLc>; Thu, 19 Jul 2001 11:11:32 -0400
Received: from [217.6.75.131] ([217.6.75.131]:59273 "EHLO
	mail.internetwork-ag.de") by vger.kernel.org with ESMTP
	id <S267582AbRGSPLT>; Thu, 19 Jul 2001 11:11:19 -0400
Message-ID: <3B56FA33.A3ED4F6E@internetwork-ag.de>
Date: Thu, 19 Jul 2001 17:18:11 +0200
From: Till Immanuel Patzschke <tip@internetwork-ag.de>
Organization: interNetwork AG
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [Q]: kernel: __alloc_pages: 3-order allocation failed.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi,

I'm running a dual PIII, 3GB box (2.4.0.SuSE and 2.4.4.SuSE) getting the error
above, despite the fact the ~700MB are still available.  In conjunction w/ the
log message I get fork failures (out of memory)...
I'm running 5500 processes having devices open and doing IP.  Many of the
processes are pppds.

Is there any way to allow the kernel using more of the available memory
(tweaking constants etc.)...
[limits have been raised...]

Thanks for the help,

Immanuel

--
Till Immanuel Patzschke                 mailto: tip@internetwork-ag.de
interNetwork AG                         Phone:  +49-(0)611-1731-121
Bierstadter Str. 7                      Fax:    +49-(0)611-1731-31
D-65189 Wiesbaden                       Web:    http://www.internetwork-ag.de



