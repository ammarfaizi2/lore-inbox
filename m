Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266137AbUHSNhe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266137AbUHSNhe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 09:37:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266141AbUHSNhd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 09:37:33 -0400
Received: from vhost12.digitarus.com ([194.242.150.12]:32210 "EHLO
	vhost12.digitarus.com") by vger.kernel.org with ESMTP
	id S266137AbUHSNhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 09:37:13 -0400
X-ClientAddr: 212.126.40.83
Message-ID: <4124AD0B.6090908@wiggly.org>
Date: Thu, 19 Aug 2004 14:37:15 +0100
From: Nigel Rantor <wiggly@wiggly.org>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: CD/DVD record
References: <Pine.LNX.4.53.0408190917140.19253@chaos>
In-Reply-To: <Pine.LNX.4.53.0408190917140.19253@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Digitarus-vhost12-MailScanner-Information: Please contact Digitarus for more information
X-Digitarus-vhost12-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> Hello all...
> Recording this stuff is basically sending some commands to
> a device and then keeping a FIFO full until done.

Lots of things that are easy to sum up on one sentence turn out the be 
hairy as a wookie, but yes, it does seem like a Simple(tm) problem.

> If `cdrecord` doesn't do it, one can hack together something
> that works in a day or so,... really good stuff in a week.

Hmm...not sure about that. Not if you do want device specific fixes in 
there too...

> Maybe it's time to ......  anyway ..... the device characteristics
> should be kept in an ASCII text file so the software doesn't have
> to be re-written everytime a new CD recorder becomes available.

Sounds good.

> Maybe the `cdrecord` author needs some competition. This sounds
> like a good beginner's project....

I'll admit to having some time on my hands but acquiring equipment to 
test with would be a stumbling block for me.

It would be nice if everyone could just put their egos aside and provide 
a united front wrt FOSS cd/dvd recording.

I was going to make some suggestions about how to do the above but then 
I have also been following the cdrecord thread and I'm not sure wading 
in on that makes sense...

   N
