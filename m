Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263203AbTDGCra (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 22:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263204AbTDGCra (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 22:47:30 -0400
Received: from flrtn-2-m1-133.vnnyca.adelphia.net ([24.55.67.133]:32918 "EHLO
	jyro.mirai.cx") by vger.kernel.org with ESMTP id S263203AbTDGCr1 (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 22:47:27 -0400
Message-ID: <3E90E976.6020006@tmsusa.com>
Date: Sun, 06 Apr 2003 19:59:02 -0700
From: J Sloan <joe@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.66-bk12 causes "rpm" errors
References: <Pine.LNX.4.44.0304062117150.1198-100000@localhost.localdomain>	 <20030406183234.1e8abd7f.akpm@digeo.com>	 <1049679689.753.170.camel@localhost> <1049680140.753.175.camel@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, I loaded 2.5.66-mm3 on my new shrike box
and was disappointed to see that rpm was broken,
and I had to boot back to 2.4.20-8 (RH) to upgrade
anything -

I'll try the

    LD_ASSUME_KERNEL=2.2.5 rpm <...>

routine and see if that does the trick -

Joe

Robert Love wrote:

>On Sun, 2003-04-06 at 21:41, Robert Love wrote:
>
>  
>
>>This has been happening since 2.5.60-ish.
>>    
>>
>
>2.5.60-mm-ish I should say... which is a big difference if this bug just
>cropped up in Linus's 2.5 tree.
>
>	Robert Love
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>


