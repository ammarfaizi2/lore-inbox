Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267856AbUHTIV4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267856AbUHTIV4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 04:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267827AbUHTIU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 04:20:58 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:50949 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S267810AbUHTIUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 04:20:33 -0400
Message-ID: <4125B539.6040402@hist.no>
Date: Fri, 20 Aug 2004 10:24:25 +0200
From: Helge Hafting <helge.hafting@hist.no>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nigel Rantor <wiggly@wiggly.org>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: CD/DVD record
References: <Pine.LNX.4.53.0408190917140.19253@chaos> <4124AD0B.6090908@wiggly.org>
In-Reply-To: <4124AD0B.6090908@wiggly.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Rantor wrote:

> Richard B. Johnson wrote:
>
>> Hello all...
>> Recording this stuff is basically sending some commands to
>> a device and then keeping a FIFO full until done.
>
>
> Lots of things that are easy to sum up on one sentence turn out the be 
> hairy as a wookie, but yes, it does seem like a Simple(tm) problem.
>
>> If `cdrecord` doesn't do it, one can hack together something
>> that works in a day or so,... really good stuff in a week.
>
>
> Hmm...not sure about that. Not if you do want device specific fixes in 
> there too...

The question then becomes - how many percent of devices in use need 
fixes to work?
A simple program with _no_ fixes, that works with correct devices only 
might not be that hard.
After it becomes popular people simply take care to buy working 
burners.  The old broken
tend to get upgraded after a while, or they can be used with the old 
cdrecord.
[...]

> I'll admit to having some time on my hands but acquiring equipment to 
> test with would be a stumbling block for me.

Take one thing at a time.  If you want to try this, start writing a 
program that works well
with your particular burner.  Chances are it'll work with many others 
too.  And then you
get patches from people who have other equipment.  You won't need to 
have everything
yourself.

>
> It would be nice if everyone could just put their egos aside and 
> provide a united front wrt FOSS cd/dvd recording.

:-) This goes for all open source.  I don't think it'll happen though. :-/

Helge Hafting
