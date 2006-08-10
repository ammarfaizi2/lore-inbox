Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030559AbWHJCZL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030559AbWHJCZL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 22:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030552AbWHJCZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 22:25:11 -0400
Received: from msr26.hinet.net ([168.95.4.126]:24246 "EHLO msr26.hinet.net")
	by vger.kernel.org with ESMTP id S1030543AbWHJCZJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 22:25:09 -0400
Message-ID: <002701c6bc24$2a9f10f0$4964a8c0@icplus.com.tw>
From: "Jesse Huang" <jesse@icplus.com.tw>
To: "Francois Romieu" <romieu@fr.zoreil.com>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>, "Jeff Garzik" <jgarzik@pobox.com>
References: <02fb01c6b147$b15b8fc0$4964a8c0@icplus.com.tw> <20060727190707.GA24157@electric-eye.fr.zoreil.com>
Subject: Hello, We had some patch need to submit for sundance.c
Date: Thu, 10 Aug 2006 10:24:54 +0800
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1807
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1807
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All:

We had some patch need to submit. Would you tell me where to get current
sundance.c for myself to generate those patch files.

Sorry, I only got this link:
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;h=f13b2a195c708fe32d8c53d05988875a51bd52e1;hb=1668b19f75cb949f930814a23b74201ad6f76a53;f=drivers/net/sundance.c

Thanks for everybody.

Best Regards,
Jesse Huang

----- Original Message ----- 
From: "Francois Romieu" <romieu@fr.zoreil.com>
To: "Jesse Huang" <jesse@icplus.com.tw>
Cc: <linux-kernel@vger.kernel.org>; <netdev@vger.kernel.org>; "Andrew
Morton" <akpm@osdl.org>; "Jeff Garzik" <jgarzik@pobox.com>
Sent: Friday, July 28, 2006 3:07 AM
Subject: Re: Hello, We have IP100A Linux driver need to submit to 2.6.x
kernel


Jesse Huang <jesse@icplus.com.tw> :
[...]
> I am IC Plus software engineer. We have IP100A 10/100 fast network adapter
> driver need to submit to Linux 2.6.x kernel. Please tell me who should I
> submit to.
>
> IP100A's device ID is 0x13f0 0200.

You do not need to do anything:

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=1668b19f75cb949f930814a23b74201ad6f76a53

As far as I have checked before forwarding Pedro Alejandro's patch, the
out-of-tree IP100 driver exhibited no significant difference with the
sundance driver.

-- 
Ueimor


