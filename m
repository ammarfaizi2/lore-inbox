Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270522AbRHHQqG>; Wed, 8 Aug 2001 12:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270523AbRHHQp5>; Wed, 8 Aug 2001 12:45:57 -0400
Received: from mail.valinux.com ([198.186.202.175]:48137 "EHLO
	mail.valinux.com") by vger.kernel.org with ESMTP id <S270522AbRHHQpo>;
	Wed, 8 Aug 2001 12:45:44 -0400
Message-ID: <3B716C87.7010907@valinux.com>
Date: Wed, 08 Aug 2001 10:44:55 -0600
From: Jeff Hartmann <jhartmann@valinux.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2 i686; en-US; 0.8) Gecko/20010215
X-Accept-Language: en
MIME-Version: 1.0
To: Gareth Hughes <gareth.hughes@acm.org>
CC: DRI-Devel <dri-devel@lists.sourceforge.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [Dri-devel] Re: DRM Linux kernel merge (update) needed, soon.
In-Reply-To: <20010807014029Z270029-28344+2126@vger.kernel.org> <3B6F86BA.14D449F4@acm.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gareth Hughes wrote:

> Dieter Nützel wrote:
> 
>> the Linux kernel DRM stuff need a merge (update), soon.
>> Even the (latest) 2.4.7-ac (3-8) stuff has some cleanups but didn't work with
>> the tdfx DRI CVS trunk driver for example.
>> I have to build the DRI CVS tdfx.o kernel module to get it working, again.
>> If I read it right the kernel stuff include some needed fixes...
> 
> 
> Agreed.
> 
> After being let go from VA, I've had to return all the graphics cards
> and machines they loaned me, and as my own supply of cards (and indeed
> all of my computer gear) is in storage somewhere in the US there isn't
> much I can do about fixing this.  You'll have to pester the guys at VA,
> most likely Jeff Hartmann.
> 
> Jeff?
> 
> -- Gareth
> 
> _______________________________________________
> Dri-devel mailing list
> Dri-devel@lists.sourceforge.net
> http://lists.sourceforge.net/lists/listinfo/dri-devel
> 
I sent a patch to Linus and Alan this morning.

-Jeff


