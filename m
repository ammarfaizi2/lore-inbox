Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316160AbSEJXwd>; Fri, 10 May 2002 19:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316172AbSEJXwc>; Fri, 10 May 2002 19:52:32 -0400
Received: from host.greatconnect.com ([209.239.40.135]:58119 "EHLO
	host.greatconnect.com") by vger.kernel.org with ESMTP
	id <S316160AbSEJXwb>; Fri, 10 May 2002 19:52:31 -0400
Message-ID: <3CDC5C0B.2070008@rackable.com>
Date: Fri, 10 May 2002 16:47:23 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0+) Gecko/20020427
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: patchset updates 2.4 ide
In-Reply-To: <Pine.LNX.4.10.10205101157290.3133-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   This fixes the dma issues I was seeing on the Tyan 2720.  Now dma is 
on by default.  Thanks Andre!

   Now I need to figure why I'm getting spammed with "invalidate: busy 
buffer".  It's not this patch as it happens on 2.4.18, and 2.4.19pre7 
without dma turned on.


Andre Hedrick wrote:
> http://www.linuxdiskcert.org/ide-2.4.19-p7.all.convert.10.patch.bz2
> http://www.linuxdiskcert.org/ide-2.4.19-p8-ac1.all.convert.10.patch.bz2
> 
> Closer to making it modular and selectable/split io/mmio channel access.
> 
> There are a few patches left out as time was a crunch.
> 
> Cheers
> 
> 
> Andre Hedrick
> LAD Storage Consulting Group
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 


