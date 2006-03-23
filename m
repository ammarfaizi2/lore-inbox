Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030231AbWCWL6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030231AbWCWL6j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 06:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030242AbWCWL6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 06:58:39 -0500
Received: from tristate.vision.ee ([194.204.30.144]:11994 "HELO mail.city.ee")
	by vger.kernel.org with SMTP id S1030231AbWCWL6i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 06:58:38 -0500
Message-ID: <44228D6D.4060405@vision.ee>
Date: Thu, 23 Mar 2006 13:58:37 +0200
From: =?UTF-8?B?TGVuYXIgTMO1aG11cw==?= <lenar@vision.ee>
User-Agent: Mail/News 1.5 (X11/20060309)
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Andrew Morton <akpm@osdl.org>, ck@vds.kolivas.org,
       linux-kernel@vger.kernel.org
Subject: Re: [ck] swap prefetching merge plans
References: <20060322205305.0604f49b.akpm@osdl.org> <200603231804.36334.kernel@kolivas.org>
In-Reply-To: <200603231804.36334.kernel@kolivas.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Thu, 23 Mar 2006 03:53 pm, Andrew Morton wrote:
>   
>>   Still don't have a compelling argument for this, IMO.
>>     
I bet there are tons and tons of very big iron server related stuff
merged daily for which ordinary Linux desktop users can't find
any compelling reasons why are those merged.

That luckily doesn't mean they are not useful. At least for some
groups for some corner cases. It's the same with this patch.
There are users who really find this patch useful. It's showing
real benefit which many can feel right away. It's not like getting a percent
more of speed out of some micro-benchmark. I really do not like
vanilla kernel in the mornings when everything slowly crawls
back (and sometimes it seems for hours). With this patch it feels
like there were no night in between.

We, Linux desktop users really like this. Why not merge this? It's not
like it's very intrusive patch.

It's the only reason why I compile my own kernels for my Ubuntu. And I
actually would like to spend that time one something more useful. And
when Con says it might consider dropping this wonderful patch all together
when mainline doesn't want it - I'm kind of shocked. No, I do not blame 
Con,
he really has tried very hard to get this included and all he gets is 
brick wall.
He doesn't deserve this I think.

But anyway I would be very sorry to see this patch sent to oblivion.

This is all I wanted to say and I hope it made difference a bit,

Lenar

