Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbTLANpW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 08:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262868AbTLANpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 08:45:22 -0500
Received: from core.kaist.ac.kr ([143.248.147.118]:46238 "EHLO
	core.kaist.ac.kr") by vger.kernel.org with ESMTP id S261735AbTLANpR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 08:45:17 -0500
Message-ID: <00ce01c3b811$475ba8d0$a5a5f88f@coreit5ezqhgk2>
From: "Cho, joon-woo" <jwc@core.kaist.ac.kr>
To: <linux-kernel@vger.kernel.org>
Subject: [Q] I have a DMA question.
Date: Mon, 1 Dec 2003 22:44:44 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4927.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I want to DMA copy data from Host computer's memory to 

PCI device's memory.(PCI device is IXP1200 Evaluation Board).

Of course, IXP1200 DMA unit can initiate DMA operation.

So I tried to use that unit, but finally I failed to use.

So I want to use host computer(or linux kernel)'s DMA mechanism

to copy data from Host computer's memory to

PCi device's memory.

How can I do that? function? simple instruction?

Please give any advice.

And if above this is complicated, 

please give me method of fast data copy between 2 memories.


Thanks!

