Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275319AbTHGNB3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 09:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275322AbTHGNB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 09:01:29 -0400
Received: from core.kaist.ac.kr ([143.248.147.118]:7619 "EHLO core.kaist.ac.kr")
	by vger.kernel.org with ESMTP id S275319AbTHGNB1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 09:01:27 -0400
Message-ID: <005f01c35ce3$6b9bcc90$a5a5f88f@core8fyzomwjks>
From: "Cho, joon-woo" <jwc@core.kaist.ac.kr>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
References: <005a01c35ca7$210f71e0$a5a5f88f@core8fyzomwjks> <1060257946.3123.31.camel@dhcp22.swansea.linux.org.uk>
Subject: Re: [Q] How can I transfer data from hard disk to PCI device'smemory
Date: Thu, 7 Aug 2003 21:57:11 +0900
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your reply, and I am very pleasant to talk with you. ^^

But english is not mother tongue, so I am little confused about your
sentence.

> The O_DIRECT I/O handling
> needs to know about stuff like page reference counts that PCI space
> doesn't have lots of older (and some current) hardware has real problems
> with PCI PCI transfers.

At above sentence, you mean that

'To handle O_DIRECT I/O, stuff like page reference is needed.

But some HW(expecially old HW) doesn't have PCI space,

so that it needs much additional work to add a PCI-PCI transferring.'

Do I understand right?


Please reply, thanks.



> So its a non trivial project, although doable



