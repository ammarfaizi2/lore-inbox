Return-Path: <linux-kernel-owner+w=401wt.eu-S932564AbXAGPRm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932564AbXAGPRm (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 10:17:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932578AbXAGPRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 10:17:42 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:44694 "EHLO
	mailout1.vmware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932564AbXAGPRl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 10:17:41 -0500
Message-ID: <45A10F13.7050003@vmware.com>
Date: Sun, 07 Jan 2007 07:17:39 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061206)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       mm-commits@vger.kernel.org, kiran@scalex86.org, ak@suse.de,
       md@google.com, mingo@elte.hu, pravin.shelar@calsoftinc.com,
       shai@scalex86.org
Subject: Re: +	spin_lock_irq-enable-interrupts-while-spinning-i386-implementation.patch
 added to -mm tree
References: <200701032112.l03LCnVb031386@shell0.pdx.osdl.net>	 <1168122953.26086.230.camel@imap.mvista.com>	 <20070106232641.68511f15.akpm@osdl.org> <1168176285.26086.241.camel@imap.mvista.com> <45A10627.9080301@vmware.com>
In-Reply-To: <45A10627.9080301@vmware.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zachary Amsden wrote:
>
>>
>> Now it fails with CONFIG_PARAVIRT off .
>>   
>
> Now it compiles both ways.  Or at least asm-offsets.c does.  Testing 
> full build...
>
> Zach

Yep, that lipstick makes the cat shine.

Zach
