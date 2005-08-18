Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932498AbVHRWSs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932498AbVHRWSs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 18:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932494AbVHRWSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 18:18:47 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:43504 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S932368AbVHRWSr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 18:18:47 -0400
Message-ID: <4305093C.9040400@mvista.com>
Date: Thu, 18 Aug 2005 15:18:36 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: anton@samba.org, clameter@engr.sgi.com, vamsi.krishnak@gmail.com,
       tony.luck@intel.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Multiple virtual address mapping for the same code on IA-64 linux
 kernel.
References: <3faf0568050816142715f14c2c@mail.gmail.com>	<Pine.LNX.4.62.0508171246070.17863@schroedinger.engr.sgi.com>	<20050818182955.GD27446@krispykreme> <20050818.142840.82684573.davem@davemloft.net>
In-Reply-To: <20050818.142840.82684573.davem@davemloft.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> From: Anton Blanchard <anton@samba.org>
> Date: Fri, 19 Aug 2005 04:29:55 +1000
> 
> 
>>Calling itanium the "fastest 64bit processor at any given clock frequency"
>>on lkml is likewise inflammatory :)
> 
> 
> I totally agree.

Since the itanium off loads a lot of its instruction steam decisions on 
to the compiler(s), where other processors just do it, one might argue 
that you can not even characterize the itanium without bundling in the 
compilers...

Not to say that is wrong but just to make it clear that saying the 
itanium speed is <X> is like saying that a cummings diesel is fast with 
out saying what sort of car/truck it is mounted in.

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
