Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271206AbTHHLSt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 07:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271211AbTHHLSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 07:18:49 -0400
Received: from core.kaist.ac.kr ([143.248.147.118]:10696 "EHLO
	core.kaist.ac.kr") by vger.kernel.org with ESMTP id S271206AbTHHLSs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 07:18:48 -0400
Message-ID: <001f01c35d9e$3df295b0$a5a5f88f@core8fyzomwjks>
From: "Cho, joon-woo" <jwc@core.kaist.ac.kr>
To: <linux-kernel@vger.kernel.org>
Subject: BT848 driver code
Date: Fri, 8 Aug 2003 20:14:32 +0900
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think that data in BT848's memory is transferred to graphic card memory

to show the captured data at monitor.

Am i right?

If right, what variable is pointed to graphic card memory  in device driver
code?

(I think in /drivers/media/video/bttv-driver.c)

Or is memory  in graphic card managed by more complex scheme as page?


Please answer, thanks.


