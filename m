Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263851AbTLRH4N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 02:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263891AbTLRH4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 02:56:13 -0500
Received: from fed1mtao06.cox.net ([68.6.19.125]:3774 "EHLO fed1mtao06.cox.net")
	by vger.kernel.org with ESMTP id S263851AbTLRH4J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 02:56:09 -0500
Message-ID: <3FE15D87.6070401@antitux.net>
Date: Thu, 18 Dec 2003 00:55:51 -0700
From: John Dee <antitux@antitux.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 keyboard not working
References: <20031218060053.GA645@gnu.org> <Pine.LNX.4.58.0312180230150.1710@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.58.0312180230150.1710@montezuma.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hrm. I was having the same problems with both my usb keyboard and mouse. 
i figure I just missed something.
haven't gotten around to looking too much into it though.
maybe in the morning.

Zwane Mwaikambo wrote:
> On Thu, 18 Dec 2003, Lennert Buytenhek wrote:
> 
> 
>>Hi,
>>
>>Halfway between having uncompressed the kernel and starting init, the console
>>starts to scroll "atkbd.c: Unknown key pressed", mentioning key code 0 (IIRC),
>>even though no keys are pressed at all.  After a while, the scrolling stops,
>>but the keyboard still doesn't work.  2.4 works fine on the same hardware.
>>
>>Hardware is an Intel SE7505VB2 board with dual 2.40GHz Xeon processors,
>>and a Logitech PS/2 "Internet keyboard."
>>
>>Ideas?
> 
> 
> May we have a look at your .config?
> 
> ta,
> 	Zwane
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

