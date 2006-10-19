Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946383AbWJSTPE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946383AbWJSTPE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 15:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946395AbWJSTPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 15:15:04 -0400
Received: from mis011-1.exch011.intermedia.net ([64.78.21.128]:57645 "EHLO
	mis011-1.exch011.intermedia.net") by vger.kernel.org with ESMTP
	id S1946383AbWJSTPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 15:15:00 -0400
Message-ID: <4537CEAB.4030809@qumranet.com>
Date: Thu, 19 Oct 2006 21:14:51 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Anthony Liguori <aliguori@us.ibm.com>
CC: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] KVM: Kernel-based Virtual Machine
References: <4537818D.4060204@qumranet.com> <p73lkncb8b4.fsf@verdi.suse.de> <4537A343.1050008@qumranet.com> <4537CBB2.2080701@us.ibm.com>
In-Reply-To: <4537CBB2.2080701@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Oct 2006 19:14:59.0632 (UTC) FILETIME=[DEEB2B00:01C6F3B2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anthony Liguori wrote:
>>
>> I have to go through the motions of creating a sourceforge project 
>> for this and uploading it.  And yes, it is free.
>
> Don't even bother creating a project.  Just submit the patches back to 
> QEMU.  There's been a lot of discussion about this functionality 
> within QEMU.  There's no reason to fork QEMU yet again (Xen has given 
> up and is now maintaining a patch queue).  In this case, there's no 
> reason why you would even need a patch queue.

We don't plan to fork qemu, too much good stuff is being added there.  
However I want to submit the patch for inclusion only after (if?) the 
driver is merged into the mainline kernel.  The patch is also not very 
pretty at the moment.

I'll post it as a patch and probably a binary rpm for the lazy.


-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

