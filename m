Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932323AbWH1BqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbWH1BqX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 21:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932320AbWH1BqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 21:46:23 -0400
Received: from msr3.hinet.net ([168.95.4.103]:34481 "EHLO msr3.hinet.net")
	by vger.kernel.org with ESMTP id S932159AbWH1BqW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 21:46:22 -0400
Message-ID: <002a01c6ca43$ae73ebd0$4964a8c0@icplus.com.tw>
From: "Jesse Huang" <jesse@icplus.com.tw>
To: "Francois Romieu" <romieu@fr.zoreil.com>
Cc: <penberg@cs.Helsinki.FI>, <akpm@osdl.org>, <dvrabel@cantab.net>,
       <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
       <david@pleyades.net>, <dominik.schulz@gauner.org>
References: <1156268234.3622.1.camel@localhost.localdomain> <20060822232730.GA30977@electric-eye.fr.zoreil.com> <20060823113822.GA17103@electric-eye.fr.zoreil.com> <20060823223032.GA25111@electric-eye.fr.zoreil.com> <026c01c6c71d$0fde1730$4964a8c0@icplus.com.tw> <20060824220758.GA19637@electric-eye.fr.zoreil.com> <20060827220816.GA21788@electric-eye.fr.zoreil.com>
Subject: Re: [PATCH] IP1000A: IC Plus update 2006-08-22
Date: Mon, 28 Aug 2006 09:45:46 +0800
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1807
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1807
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It's Ok. Thanks for that.

Jesse
----- Original Message ----- 
From: "Francois Romieu" <romieu@fr.zoreil.com>
To: "Jesse Huang" <jesse@icplus.com.tw>
Cc: <penberg@cs.Helsinki.FI>; <akpm@osdl.org>; <dvrabel@cantab.net>;
<linux-kernel@vger.kernel.org>; <netdev@vger.kernel.org>;
<david@pleyades.net>; <dominik.schulz@gauner.org>
Sent: Monday, August 28, 2006 6:08 AM
Subject: Re: [PATCH] IP1000A: IC Plus update 2006-08-22


Francois Romieu <romieu@fr.zoreil.com> :
> Jesse Huang <jesse@icplus.com.tw> :
> [...]
>
> Added:
> 0039-ip1000-cosmetic-in-ipg_interrupt_handler.txt
> 0040-ip1000-irq-handler-and-device-close-race.txt
> 0041-ip1000-schedule-the-host-error-recovery-to-user-context.txt
> 0042-ip1000-no-need-to-mask-a-constant-field-with-RSVD_MASK.txt

Added:
0043-ip1000-use-the-new-IRQF_-constants-and-the-dma_-alloc-free-_coherent-AP
I.txt
0044-ip1000-mixed-case-and-upper-case-removal.txt
0045-ip1000-add-ipg_-r-w-8-16-32-macros.txt

The patches beyond 0043 are only available through HTTP. Since 0043
needs a recent enough kernel and the current driver has branched from
an old release, I plan to rebase my branch. Does it raise any objection
or remark ?

-- 
Ueimor


