Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271401AbTHDHSZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 03:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271408AbTHDHSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 03:18:25 -0400
Received: from core.kaist.ac.kr ([143.248.147.118]:2995 "EHLO core.kaist.ac.kr")
	by vger.kernel.org with ESMTP id S271401AbTHDHSY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 03:18:24 -0400
Message-ID: <00a001c35a58$02c20f00$a5a5f88f@core8fyzomwjks>
From: "Cho, joon-woo" <jwc@core.kaist.ac.kr>
To: <linux-kernel@vger.kernel.org>
Subject: [Q] Question about memory access
Date: Mon, 4 Aug 2003 16:14:14 +0900
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I am highly curious about memory access problem.

Maybe this is not exactly 'kernel' development problem, but I think this is
highly

related to 'kernel'.


Anyway my question is below.

If someone want to transfer large data from some device to memory, he may
use DMA method.

At this point, i am confused.

I think that only one process can access physical memory(RAM) at a time.

During DMA data transferring(This may need  long time), how can other
physical memory access occurs?

I think that this is solved by time-sharing, process switching, or etc. Is
it true?

Please say abstract mechanism or kernel code location about this problem.


My english is poor, so question meaning may be confused. I am sorry about
this.

Please answer my question. Thanks!


