Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313161AbSDDMng>; Thu, 4 Apr 2002 07:43:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313160AbSDDMnQ>; Thu, 4 Apr 2002 07:43:16 -0500
Received: from [195.63.194.11] ([195.63.194.11]:1297 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S312311AbSDDMnI>;
	Thu, 4 Apr 2002 07:43:08 -0500
Message-ID: <3CAC3BE1.9030300@evision-ventures.com>
Date: Thu, 04 Apr 2002 13:41:21 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.7-dj3
In-Reply-To: <20020404054923.A28437@suse.de> <Pine.NEB.4.44.0204040946500.7845-100000@mimas.fachschaften.tu-muenchen.de> <20020404141647.T20040@suse.de> <20020404143722.V20040@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Thu, Apr 04, 2002 at 02:16:47PM +0200, Dave Jones wrote:
>  > On Thu, Apr 04, 2002 at 09:50:32AM +0200, Adrian Bunk wrote:
>  >  > pdc4030.c: In function `promise_multwrite':
>  >  > pdc4030.c:447: warning: passing arg 2 of `bio_kmap_irq' makes pointer from
>  >  > integer without a cast
>  >  > pdc4030.c: In function `promise_rw_disk':
>  >  > pdc4030.c:664: structure has no member named `channel'
>  > 
>  > Ok, I'm confused.
>  > This is a compile failure from 2.5.8-pre1.
>  > The line numbers don't even match up to whats in -dj3
> 
> 
> My bad. _I_ was looking at a wrong tree.
> I'll fix these bits up later and push them Martins way, as there
> are a few other small IDE bits that have been lingering in my
> tree since 2.5.2 days.

Well actually I was short before having a look in to the -dj3 series,
but first I have to read through 2.5.8-pre1.
However I would be really gald if you could throw the code in question
in fragments called patches at me ;-).

