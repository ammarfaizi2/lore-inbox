Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264284AbUBPMer (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 07:34:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263953AbUBPMer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 07:34:47 -0500
Received: from host-64-65-253-246.alb.choiceone.net ([64.65.253.246]:62162
	"EHLO gaimboi.tmr.com") by vger.kernel.org with ESMTP
	id S265290AbUBPMeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 07:34:44 -0500
Message-ID: <4030B48F.2070603@tmr.com>
Date: Mon, 16 Feb 2004 07:16:15 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.3-rc3-mm1
References: <20040216015823.2dafabb4.akpm@osdl.org>
In-Reply-To: <20040216015823.2dafabb4.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >
 >     Jeff
 >
 >
 >
 > -
 > To unsubscribe from this list: send the line "unsubscribe 
linux-kernel" in
 > the body of a message to majordomo@vger.kernel.org
 > More majordomo info at  http://vger.kernel.org/majordomo-info.html
 > Please read the FAQ at  http://www.tux.org/lkml/
 >

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.3-rc3/2.6.3-rc3-mm1/
> 
> 
> - New hotplug CPU implementation from Rusty
> 
> - Dropped the x86 CPU-type selection patches

Was there a problem with this? Seems like a good start to allow cleaning 
up some "but I don't have that CPU" things which embedded and tiny 
systems really would like to eliminate.
> 
> - Added support for dynamic allocation of unix98 ptys.

Good to get more testing on this.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
