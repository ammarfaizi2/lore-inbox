Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750740AbVLHIEz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbVLHIEz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 03:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbVLHIEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 03:04:54 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:25570 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1750740AbVLHIEy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 03:04:54 -0500
Message-ID: <4397E9FA.7000609@aitel.hist.no>
Date: Thu, 08 Dec 2005 09:08:26 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Poole <mdpoole@troilus.org>
CC: Jeffrey Hundstad <jeffrey.hundstad@mnsu.edu>,
       Benjamin LaHaise <bcrl@kvack.org>, Lee Revell <rlrevell@joe-job.com>,
       Dirk Steuwer <dirk@steuwer.de>, linux-kernel@vger.kernel.org
Subject: Re: Runs with Linux (tm)
References: <1133779953.9356.9.camel@laptopd505.fenrus.org>	<20051205121851.GC2838@holomorphy.com>	<20051206011844.GO28539@opteron.random>	<43944F42.2070207@didntduck.org>	<loom.20051206T094816-40@post.gmane.org>	<20051206104652.GB3354@favonius>	<loom.20051206T173458-358@post.gmane.org>	<20051207141720.GA533@kvack.org> <1133982741.17901.32.camel@mindpipe>	<20051207194746.GG533@kvack.org> <439760FF.3060605@mnsu.edu> <874q5k4k3z.fsf@graviton.dyn.troilus.org>
In-Reply-To: <874q5k4k3z.fsf@graviton.dyn.troilus.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Poole wrote:

>Jeffrey Hundstad writes:
>
>  
>
>>It might be possible to add a serial number to the logo, and keep a
>>database that maintains a current status of the device in the Linux
>>kernel.
>>
>>Does this make sense?
>>    
>>
>
>Not especially.  To be accurate, it would have to be bumped every time
>a driver is removed from the kernel -- or, more accurately, every time
>the in-kernel API changes.  To be useful, such an increment would have
>to only happen once a year or so, or else updating the packaging is
>too much work.  Currently, the in-kernel API changes every month or
>two, which means a driver compatibility serial number would be
>inaccurate, futile, or both.
>  
>
Well, a driver that gets _into_ the tree will get a lot of maintenance
for free.  Basically, someone wanting to change an internal interface
normally takes care of all internal users of that interface. (And yes,
there are some exceptions but this is the rule.)

Still, to prevent everlasting "runs with linux" stickers, give them one-year
stickers only.  Get a GPL driver into the kernel tree in 2005, and you
get the "runs with linux 2005" sticker.  To get a sticker for 2006, 
there have
to be an active maintainer. This could be the company doing maintenance. Or,
in case of really popular hardware, it could be the kernel regulars doing
it voluntarily. In the latter case, the company would only need to ask 
for the 2006 sticker.

Once a driver gets no maintenance, neither from the company nor the 
community,
no more stickers is handed out for it. 

And of course it shouldn't be stickers only, but also logos they can put on
their websites.  Linux people usually look up such things on the web
when planning purchases. Also, a company that _wants_ to support linux can
show that they still support the previous generation of products.
They have no use for physical stickers for a product that doesn't sell much,
but having a logo is advertising, they show that their products have
long-time viability for linux users.

Helge Hafting
