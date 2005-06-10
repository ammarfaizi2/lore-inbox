Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261194AbVFJT5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261194AbVFJT5M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 15:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbVFJT5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 15:57:12 -0400
Received: from karma.reboot.ca ([67.15.48.17]:11399 "EHLO karma.reboot.ca")
	by vger.kernel.org with ESMTP id S261194AbVFJT5K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 15:57:10 -0400
X-ClientAddr: 70.67.196.121
Message-ID: <018801c56df6$ef130270$6702a8c0@niro>
From: "Andre" <andre@rocklandocean.com>
To: "Zwane Mwaikambo" <zwane@arm.linux.org.uk>
Cc: <linux-kernel@vger.kernel.org>
References: <00fb01c56dec$91f0e440$6702a8c0@niro> <Pine.LNX.4.61.0506101304520.31175@montezuma.fsmlabs.com>
Subject: Re: ZFx86 support broken?
Date: Fri, 10 Jun 2005 12:59:38 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-Reboot-MailScanner-Information: Please contact the ISP for more information
X-Reboot-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-Reboot-MailScanner-SpamCheck: not spam, SpamAssassin (score=-0.728,
	required 5, autolearn=spam, AWL -0.12, BAYES_00 -2.60,
	RCVD_IN_SORBS_DUL 1.99)
X-MailScanner-From: andre@rocklandocean.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It looks like it may be having trouble with userspace, try confirming
> that it is indeed mounting root and doing run_init_process.

How can I confirm this? I am booting off a livecd and I have tried to see
whether the 'debug' bootprompt option would give more info, but no such
luck.
My current system is based on 2.4.27 (gcc 3.3.1).and I haven't found any
clear info yet on how to upgrade to 2.6 otherwise I would just try to
upgrade to 2.6 and build a kernel with some printk's.

