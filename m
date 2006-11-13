Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755048AbWKMPwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755048AbWKMPwv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 10:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755165AbWKMPwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 10:52:51 -0500
Received: from ref.nmedia.net ([66.39.177.2]:38566 "EHLO ref.nmedia.net")
	by vger.kernel.org with ESMTP id S1755048AbWKMPwv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 10:52:51 -0500
Date: Mon, 13 Nov 2006 07:52:49 -0800 (PST)
From: Shaun Q <shaun@c-think.com>
X-X-Sender: shaun@ref.nmedia.net
To: Stephen Clark <Stephen.Clark@seclark.us>
cc: linux-kernel@vger.kernel.org
Subject: Re: Dual cores on Core2Duo not detected?
In-Reply-To: <4558773A.4040803@seclark.us>
Message-ID: <Pine.BSO.4.64.0611130752270.21533@ref.nmedia.net>
References: <Pine.BSO.4.64.0611122322060.30536@ref.nmedia.net>
 <4558773A.4040803@seclark.us>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 13 Nov 2006, Stephen Clark wrote:

> Hi Shaun,
>
> Someone mentioned some bioses have an entry to enable the second core.
>
> HTH,
> Steve
>
> Shaun Q wrote:
>
>> Hi there everyone --
>> 
>> I'm trying to build a custom kernel for using both cores of my new Core2Duo 
>> E6600 processor...
>> 
>> I thought this was simply a matter of enabling the SMP support in the 
>> kernel .config and recompiling, but when the kernel comes back up, still 
>> only one core is detected.
>> 
>> With the default vanilla text-based SuSE 10.1 install, it does find both 
>> cores...
>> 
>> Anyone have any pointers for me on what I might be missing?
>> 
>> Thanks!
>> Shaun
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
>> 
>
>
> -- 
>
> "They that give up essential liberty to obtain temporary safety, deserve 
> neither liberty nor safety."  (Ben Franklin)
>
> "The course of history shows that as a government grows, liberty decreases." 
> (Thomas Jefferson)
>
>
>
>
Thanks Steve :)

This bios does have such an entry and it is enabled.

Thanks!
Shaun
