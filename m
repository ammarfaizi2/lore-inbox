Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263167AbTC1WEc>; Fri, 28 Mar 2003 17:04:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263168AbTC1WEb>; Fri, 28 Mar 2003 17:04:31 -0500
Received: from freeside.toyota.com ([63.87.74.7]:51338 "EHLO
	freeside.toyota.com") by vger.kernel.org with ESMTP
	id <S263167AbTC1WE2>; Fri, 28 Mar 2003 17:04:28 -0500
Message-ID: <3E84C98A.50201@tmsusa.com>
Date: Fri, 28 Mar 2003 14:15:38 -0800
From: jjs <jjs@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: NICs trading places ?
References: <20030328221037.GB25846@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That's bitten me several times, not
just 2.4 -> 2.5 but also within different
versions of 2.4-RHL :-(

I've head you can spell out pci IDs
in modules.conf to nail it down but
I haven't gotten around to trying it -

Joe

Dave Jones wrote:

>I just upgraded a box with 2 NICs in it to 2.5.66, and found
>that what was eth0 in 2.4 is now eth1, and vice versa.
>Is this phenomenon intentional ? documented ?
>What caused it to do this ?
>
>The box in question has a DEC Tulip and a 3com 3c905,
>but I imagine this would affect any system with >1 NIC
>of different vendors/drivers ?
>
>		Dave
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>


