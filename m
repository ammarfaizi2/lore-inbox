Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272491AbTGaOWM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 10:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272488AbTGaOWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 10:22:12 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:58376 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S272491AbTGaOWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 10:22:08 -0400
Message-ID: <3F2928AD.90501@techsource.com>
Date: Thu, 31 Jul 2003 10:33:17 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
CC: Jamie Lokier <jamie@shareable.org>,
       "Richard B. Johnson" <root@chaos.analogic.com>,
       James Simmons <jsimmons@infradead.org>, Charles Lepple <clepple@ghz.cc>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Turning off automatic screen clanking
References: <Pine.LNX.4.44.0307291750170.5874-100000@phoenix.infradead.org> <Pine.LNX.4.53.0307291338260.6166@chaos> <Pine.LNX.4.53.0307292015580.11053@montezuma.mastecende.com> <20030730012533.GA18663@mail.jlokier.co.uk> <Pine.LNX.4.53.0307292136050.11053@montezuma.mastecende.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Zwane Mwaikambo wrote:
> On Wed, 30 Jul 2003, Jamie Lokier wrote:
> 
> 
>>One of Richard's points is that there is presently no way to fix the
>>box in userspace.  If the kernel crashes during boot, it will blank
>>the screen and there is no way to unblank it in that state.
> 
> 
> Well something like this should work without complicating things during 
> panic.
> 

[snip]

This looks like it prevents blanking after panic.  What about UNblanking 
during panic?


