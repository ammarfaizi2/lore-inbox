Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbWBREMD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbWBREMD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 23:12:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbWBREMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 23:12:03 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:55465 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750739AbWBREL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 23:11:57 -0500
Message-ID: <43F69E98.7050303@jp.fujitsu.com>
Date: Sat, 18 Feb 2006 13:12:08 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: Kamezawa Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dave Hansen <haveblue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Yasunori Goto <y-goto@jp.fujitsu.com>,
       lhms <lhms-devel@lists.sourceforge.net>
Subject: Re: [Lhms-devel] Re: [PATCH] change memoryX->phys_device from number
 to symlink [1/2] generic func
References: <43F570B1.7050302@jp.fujitsu.com> <20060217222430.GA14847@suse.de> <43F6775C.8030208@jp.fujitsu.com>
In-Reply-To: <43F6775C.8030208@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kamezawa Hiroyuki wrote:
> Greg KH wrote:
>>
>> You should bring this up on the acpi mailing list, as I know Pat Mochel
>> has redone the whole "acpi in sysfs" thing, so this patch will break
>> those patches (or his will break yours.)
>>
>> I suggest you discuss this with him.
>>
Ah..okay. it's this ..

http://www.kernel.org/pub/linux/kernel/people/mochel/patches/acpi/driver-model/

It looks things are completely changed ;)

I'd like to look into this more before going ahead.

Thanks,
-- Kame


