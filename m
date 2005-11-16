Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965188AbVKPCnH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965188AbVKPCnH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 21:43:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965189AbVKPCnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 21:43:07 -0500
Received: from zeus1.kernel.org ([204.152.191.4]:56974 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S965188AbVKPCnF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 21:43:05 -0500
In-Reply-To: <437A8142.7030106@watson.ibm.com>
References: <43796596.2010908@watson.ibm.com> <1F92A563-B430-49FE-895E-FB93DC64981E@comcast.net> <437A613A.1020705@watson.ibm.com> <4ABDC730-2888-4DBE-B1DC-62362A87EEB7@comcast.net> <437A8142.7030106@watson.ibm.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A604D1E7-577F-4452-8E7B-A9DF871E08CC@comcast.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Parag Warudkar <kernel-stuff@comcast.net>
Subject: Re: [Patch 1/4] Delay accounting: Initialization
Date: Tue, 15 Nov 2005 21:41:21 -0500
To: nagar@watson.ibm.com
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Nov 15, 2005, at 7:45 PM, Shailabh Nagar wrote:

> So how about this:
>
> Have /proc/sys/kernel/delayacct and a corresponding kernel boot  
> parameter (for setting
> the switch early) which control just the collection of data.  
> Allocation always happens.

Yep, if per task isn't worth doing that sounds reasonable.

Parag
