Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269262AbRHGSTj>; Tue, 7 Aug 2001 14:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269263AbRHGSTb>; Tue, 7 Aug 2001 14:19:31 -0400
Received: from mail.libertysurf.net ([213.36.80.91]:5162 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S269262AbRHGSTX>; Tue, 7 Aug 2001 14:19:23 -0400
Message-ID: <3B704EC5.2090900@paulbristow.net>
Date: Tue, 07 Aug 2001 20:25:41 +0000
From: Paul Bristow <paul@paulbristow.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en-us
MIME-Version: 1.0
To: "Kevin P. Fleming" <kevin@labsysgrp.com>
CC: Richard Gooch <rgooch@ras.ucalgary.ca>,
        Martin Wilck <Martin.Wilck@fujitsu-siemens.com>,
        devfs mailing list <devfs@oss.sgi.com>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]: ide-floppy & devfs
In-Reply-To: <Pine.LNX.4.30.0107272127060.16993-100000@biker.pdb.fsc.net><000701c116f5$8268a820$6baaa8c0@kevin> <200107281215.f6SCFt716350@mobilix.ras.ucalgary.ca> <001001c11781$9db10a50$6baaa8c0@kevin>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK.  I am the maintainer of the code, and I will try to make sense out 
of all the patches that got submitted while I was away on holiday...

BTW, I also am looking forward to 2.5 starting when we can get this 
devfs stuff really working.  I have a version of ide-floppy "working 
with devfs" on my system but it still has too many funnies.

Watch this space.

Paul

Kevin P. Fleming wrote:
> <snip>
> 
>>Are you saying that the two patch conflict? If not, can someone please
>>verify that both together are safe? Or is your patch a superset?
>>
>>
> 
> Actually, the patches are complementary. However, my patch I won't be
> continuing to work on, as the entire way that partitions are
> read/validated/passed to devfs/etc will be changed in 2.5, and I've already
> forwarded this patch over to the maintainer of that code (whose name escapes
> my memory at the moment). So I'd say don't worry about it from the devfs
> end, you'll see the changes once 2.5 opens and these changes get merged in
> to that tree.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 

Paul

Email: 
paul@paulbristow.net
Web: 
http://paulbristow.net
ICQ: 
11965223

