Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992566AbWJTHhv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992566AbWJTHhv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 03:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992569AbWJTHhv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 03:37:51 -0400
Received: from mis011-1.exch011.intermedia.net ([64.78.21.128]:52951 "EHLO
	mis011-1.exch011.intermedia.net") by vger.kernel.org with ESMTP
	id S2992566AbWJTHhu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 03:37:50 -0400
Message-ID: <45387CC9.1060500@qumranet.com>
Date: Fri, 20 Oct 2006 09:37:45 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Anthony Liguori <aliguori@us.ibm.com>
CC: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] KVM: Kernel-based Virtual Machine
References: <4537818D.4060204@qumranet.com> <p73lkncb8b4.fsf@verdi.suse.de> <4537A343.1050008@qumranet.com> <4537CBB2.2080701@us.ibm.com> <4537CEAB.4030809@qumranet.com> <4537D1FA.9090502@us.ibm.com>
In-Reply-To: <4537D1FA.9090502@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Oct 2006 07:37:49.0932 (UTC) FILETIME=[A4E33AC0:01C6F41A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anthony Liguori wrote:
>>
>> We don't plan to fork qemu, too much good stuff is being added 
>> there.  However I want to submit the patch for inclusion only after 
>> (if?) the driver is merged into the mainline kernel.  The patch is 
>> also not very pretty at the moment.
>
> I would recommend the opposite approach.  Something can go in QEMU 
> more quickly than in the kernel and you'll get people actually testing 
> it.  If it gets in the kernel and there's no major userspace presence 
> you won't have nearly the same amount of testers...

I'll try doing both at once :)

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

