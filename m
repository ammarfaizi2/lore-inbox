Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265797AbUAQJBB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 04:01:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265888AbUAQJBB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 04:01:01 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:29173 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S265797AbUAQJA7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 04:00:59 -0500
Message-ID: <4008F9B3.9060404@mvista.com>
Date: Sat, 17 Jan 2004 01:00:35 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Amit S. Kale" <amitkale@emsyssoft.com>
CC: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>, kgdb-bugreport@lists.sourceforge.net,
       mpm@selenic.com
Subject: Re: KGDB documentation [Re: [discuss] KGDB 2.0.3 with fixes and development
 in ethernet interface]
References: <200401161759.59098.amitkale@emsyssoft.com> <200401162045.59591.amitkale@emsyssoft.com> <20040116155223.GA258@elf.ucw.cz> <200401171157.27534.amitkale@emsyssoft.com>
In-Reply-To: <200401171157.27534.amitkale@emsyssoft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amit S. Kale wrote:
> Hi All,
> 
> I extracted this part of Pavel the patch he had submitted for 2.0.3 and 
> appended it to README file. Since Pavel has't noticed it, I am assuming that 
> most people won't notice it either.
> 
> Do people think pushing documentation into Documentation/kgdb directory is a 
> better idea?
> 
> Another note about kgdb documentation - 
> There is a lot of documentation at kgdb.sourceforge.net. It's more of howto 
> type rather than manpages. Will it be too much as a documentation in kernel 
> sources.
> 
> Any ideas on which things to put into Documentation/kgdb and which to have on 
> a website.

It should all be in the kernel tree.  See, for example, the mm patch.

-g

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

