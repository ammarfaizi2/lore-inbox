Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261211AbUKMXvw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261211AbUKMXvw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 18:51:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261213AbUKMXvv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 18:51:51 -0500
Received: from fw.osdl.org ([65.172.181.6]:18115 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261211AbUKMXvo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 18:51:44 -0500
Message-ID: <41969DAF.3080104@osdl.org>
Date: Sat, 13 Nov 2004 15:50:07 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Josef E. Galea" <josefeg@euroweb.net.mt>
CC: linux-kernel@vger.kernel.org
Subject: Re: System call number
References: <41969845.1060803@euroweb.net.mt>
In-Reply-To: <41969845.1060803@euroweb.net.mt>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Josef E. Galea wrote:

> Hi,

> Can anyone tell me the system call number for the function 
> write_swap_page() (in kernel/power/pmdisk.c) as I can't find it in 
> unistd.h.

What kernel version?  I don't see what source file in
2.6.10-rc1-bk23.

There are lots of kernel functions that don't have syscall numbers.
E.g, write_page() in kernel/power/swsusp.c.

-- 
~Randy
