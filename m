Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261260AbUKNIu0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbUKNIu0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 03:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261261AbUKNIu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 03:50:26 -0500
Received: from mail3.euroweb.net.mt ([217.145.4.38]:21474 "EHLO
	mail3.euroweb.net.mt") by vger.kernel.org with ESMTP
	id S261260AbUKNIuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 03:50:21 -0500
Message-ID: <41971C4E.6030400@euroweb.net.mt>
Date: Sun, 14 Nov 2004 09:50:22 +0100
From: "Josef E. Galea" <josefeg@euroweb.net.mt>
User-Agent: Mozilla Thunderbird 0.9 (Windows/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: System call number
References: <41969845.1060803@euroweb.net.mt> <41969DAF.3080104@osdl.org>
In-Reply-To: <41969DAF.3080104@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:

> Josef E. Galea wrote:
>
>> Hi,
>
>
>> Can anyone tell me the system call number for the function 
>> write_swap_page() (in kernel/power/pmdisk.c) as I can't find it in 
>> unistd.h.
>
>
> What kernel version?  I don't see what source file in
> 2.6.10-rc1-bk23.
>
> There are lots of kernel functions that don't have syscall numbers.
> E.g, write_page() in kernel/power/swsusp.c.
>
Version 2.6.8.1. The mention file can be found at 
http://lxr.linux.no/source/kernel/power/pmdisk.c?v=2.6.8.1#L191

Thanks
Josef
