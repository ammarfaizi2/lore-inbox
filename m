Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbUA3VlW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 16:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263639AbUA3VlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 16:41:22 -0500
Received: from lanshark.nersc.gov ([128.55.16.114]:3200 "EHLO
	lanshark.nersc.gov") by vger.kernel.org with ESMTP id S261522AbUA3VlU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 16:41:20 -0500
Message-ID: <401ACF71.1020306@lbl.gov>
Date: Fri, 30 Jan 2004 13:41:05 -0800
From: Thomas Davis <tadavis@lbl.gov>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040124
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Thomas Davis <TADavis@lbl.gov>
CC: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.2-rc2
References: <Pine.LNX.4.58.0401251844440.32583@home.osdl.org> <401ACB1E.9070304@lbl.gov>
In-Reply-To: <401ACB1E.9070304@lbl.gov>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I knew I should of check the mm's first..

2.6.2-rc2 won't boot, 2.6.2-rc2-mm1 does..

sorry.
thomas

Thomas Davis wrote:
> Linus Torvalds wrote:
> 
>> It's being uploaded right now, and the BK trees should already
>> be uptodate.
>>
>> There's a x86-64 update and IRDA updates here, and a number of USB 
>> storage
>> fixes. The rest is pretty small. Full changelog from -rc1 appended.
>>
>>         Linus
>>
> 
> Did someone change the Intel CPU detection code in this version?
> 
> It won't boot on my dual athlon MP system.
> 
> 2.6.2-rc1 does boot.
> 
> thomas
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

