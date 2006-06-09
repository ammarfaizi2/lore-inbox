Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751325AbWFIA2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbWFIA2f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 20:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbWFIA2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 20:28:35 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.81]:34455 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id S1751325AbWFIA2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 20:28:34 -0400
Message-ID: <4488C098.90802@cmu.edu>
Date: Thu, 08 Jun 2006 20:28:08 -0400
From: George Nychis <gnychis@cmu.edu>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060529)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Barry K. Nathan" <barryn@pobox.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: what processor family does intel core duo L2400 belong to?
References: <4488B159.2070806@cmu.edu> <986ed62e0606081650k227c948dy2c675bedd7a254fa@mail.gmail.com>
In-Reply-To: <986ed62e0606081650k227c948dy2c675bedd7a254fa@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Barry K. Nathan wrote:
> On 6/8/06, George Nychis <gnychis@cmu.edu> wrote:
> 
>> My guess is the "Pentium-4/Celeron(P4-based)/Pentium-4 M/Xeon" family,
>> but maybe someone has a different opinion or can support it.
>>
>> Here is the /proc/cpuinfo:
>> processor       : 0
>> vendor_id       : GenuineIntel
>> cpu family      : 6
>> model           : 14
> 
> [snip]
> 
> "Pentium-4/Celeron(P4-based)/Pentium-4 M/Xeon" are all family 15, not 
> family 6.
> 
> I have a Pentium M, it's family 6 model 13. Also, AFAIK the Intel Core
> is based on the Pentium M (which in turn is based on Pentium III). So,
> my personal best guess would be to choose "Pentium M".
> 
> Unfortunately, I don't have one of these (Intel Core) at this point,
> so I can't test it myself...

Put me in your shoes, what would you test to see which one is the true 
choice?
