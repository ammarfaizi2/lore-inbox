Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751052AbWIAES0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbWIAES0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 00:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750884AbWIAES0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 00:18:26 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:10955 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1750751AbWIAES0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 00:18:26 -0400
From: Grant Coady <gcoady.lk@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Query: DMA Engine support in make oldconfig
Date: Fri, 01 Sep 2006 14:18:23 +1000
Organization: http://bugsplatter.mine.nu/
Reply-To: Grant Coady <gcoady.lk@gmail.com>
Message-ID: <7vcff2l2q7s1mqjlb3g35dodgrcmlba57q@4ax.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

make oldconfig from 2.6.17.11 to 2.6.18-rc5: This help text doesn't say 
what the right choice should be?  Unclear to me anyway, so I take the 
default, is that bad for an x86 32-bit box?
"
* DMA Engine support
*
Support for DMA engines (DMA_ENGINE) [N/y/?] (NEW) ?

DMA engines offload copy operations from the CPU to dedicated
hardware, allowing the copies to happen asynchronously.
"
Thanks,
Grant.
