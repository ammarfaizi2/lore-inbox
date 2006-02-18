Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751816AbWBRBZf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816AbWBRBZf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 20:25:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751820AbWBRBZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 20:25:35 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:64679 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751816AbWBRBZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 20:25:34 -0500
Message-ID: <43F6775C.8030208@jp.fujitsu.com>
Date: Sat, 18 Feb 2006 10:24:44 +0900
From: Kamezawa Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dave Hansen <haveblue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Yasunori Goto <y-goto@jp.fujitsu.com>,
       lhms <lhms-devel@lists.sourceforge.net>
Subject: Re: [PATCH] change memoryX->phys_device from number to symlink [1/2]
 generic func
References: <43F570B1.7050302@jp.fujitsu.com> <20060217222430.GA14847@suse.de>
In-Reply-To: <20060217222430.GA14847@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> 
> You should bring this up on the acpi mailing list, as I know Pat Mochel
> has redone the whole "acpi in sysfs" thing, so this patch will break
> those patches (or his will break yours.)
> 
> I suggest you discuss this with him.
> 

Thanks, I'll go acpi-list first.
--Kame

