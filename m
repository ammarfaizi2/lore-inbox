Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263718AbTDYVzK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 17:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263890AbTDYVyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 17:54:20 -0400
Received: from franka.aracnet.com ([216.99.193.44]:50624 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263718AbTDYVyP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 17:54:15 -0400
Date: Fri, 25 Apr 2003 15:06:23 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Timothy Miller <miller@techsource.com>
cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: TASK_UNMAPPED_BASE & stack location
Message-ID: <3280000.1051308382@[10.10.2.4]>
In-Reply-To: <3EA9B061.600@techsource.com>
References: <459930000.1051302738@[10.10.2.4]>
 <b8c7no$u59$1@cesium.transmeta.com> <1750000.1051305030@[10.10.2.4]>
 <3EA9B061.600@techsource.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> 128Mb of it? The bottom page, or even a few Mb, sure ... 
>> but 128Mb seems somewhat excessive ..
>>  
>> 
> Considering that your process space is 4gig, and that that 128Mb doesn't
> really exist anywhere (no RAM, no page table entries, nothing), it's
> really not excessive.  

I need the virtual space.

> If you're so strapped for process space that you
> need that extra 128Mb, then you probably shouldn't be using a 32-bit
> processor.

Point me at a cheap 32 cpu 64-bit machine. Market realities dicate
otherwise.

M.

