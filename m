Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264048AbUFSP4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264048AbUFSP4S (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 11:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264085AbUFSP4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 11:56:18 -0400
Received: from ns1.skjellin.no ([80.239.42.66]:7660 "HELO mail.skjellin.no")
	by vger.kernel.org with SMTP id S264048AbUFSP4Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 11:56:16 -0400
Message-ID: <40D46220.9030806@tomt.net>
Date: Sat, 19 Jun 2004 17:56:16 +0200
From: Andre Tomt <andre@tomt.net>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Ian Kumlien <pomac@vapor.com>
Subject: Re: [sundance] Known problems?
References: <1087650302.2971.44.camel@big>  <40D43E26.7060207@tomt.net> <1087651887.2971.47.camel@big>
In-Reply-To: <1087651887.2971.47.camel@big>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Kumlien wrote:
> On Sat, 2004-06-19 at 15:22, Andre Tomt wrote:
>>FYI;
>>
>>Other than beeing a slow card with mmio-bugs, the only problems I have 
>>had with that card was when having a kernel patched with the now defunct 
>>and buggy IMQ. Problems were identical.
> 
> 
> Yeah i know about the MMIO bit, but i never had this problem before...
> Even when loading it with full 100mbit bw (but that was on 2.4).

I have not used the card since around 2.6.4, but it worked fine back 
then. Did some performance testing on it, with high data and packets/s 
rates, so it did get a fair amount of beating.

> Can't it be to paranoid watchdog timings?
> (Btw, what is IMO, I'd think it meant 'in my opinion' but, heh =))

Not IMO, IMQ, Q as in q ;-)

If you don't know what it is, you most likely aren't using it. I'm not 
avare of any distributions having it applied. It's used for combinding 
several network packet queues into one for example.

