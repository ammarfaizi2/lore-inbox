Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262300AbVHCPum@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262300AbVHCPum (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 11:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262301AbVHCPum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 11:50:42 -0400
Received: from out01.east.net ([210.56.193.7]:28591 "EHLO out01.east.net")
	by vger.kernel.org with ESMTP id S262300AbVHCPuk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 11:50:40 -0400
Subject: Re: [PATCH] latency logger for
	realtime-preempt-2.6.12-final-V0.7.51-30
From: Yang Yi <yang.yi@bmrtech.com>
Reply-To: yang.yi@bmrtech.com
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Wed, 03 Aug 2005 12:19:17 +0800
Message-Id: <1123042757.2997.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Hi, Ingo
>> 
>> This patch can record interrupt-off latency, preemption-off latency 
>> and wakeup latency in a big history array, in the meanwhile, it 
>> dummies up printks produced by these latency timing.

>looks pretty good! I'll look at merging your patch after KS/OLS.
>
>	Ingo

Hi, ingo

Do you have any trouble while you merge that latency logger patch?

