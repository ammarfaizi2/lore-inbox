Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261563AbSKDRIY>; Mon, 4 Nov 2002 12:08:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261642AbSKDRIX>; Mon, 4 Nov 2002 12:08:23 -0500
Received: from adsl-67-120-62-187.dsl.lsan03.pacbell.net ([67.120.62.187]:55563
	"EHLO exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S261563AbSKDRIX>; Mon, 4 Nov 2002 12:08:23 -0500
Message-ID: <11E89240C407D311958800A0C9ACF7D1A33C8F@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'Werner Almesberger'" <wa@almesberger.net>
Cc: "'Richard B. Johnson'" <root@chaos.analogic.com>,
       Ken Ryan <newsryan@leesburg-geeks.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [STATUS 2.5] October 30, 2002
Date: Mon, 4 Nov 2002 09:14:55 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, November 01, 2002 at 4:33 PM, Werner Almesberger wrote:
> Ed Vance wrote:
> > functional as long as he can keep up. For the memory, the many separate 
> > bit error events would cause only correctable errors, as long as the 
> > scrubbing can keep up.
> 
> Don't those bit errors have a Poissonian character ? If so, it's
> impossible to "keep up". All you can do is make the interval small
> enough that, on average, it takes a long time until you get hit
> twice (or more often) in that interval.

Yes.
> 
> A better example would be car tires on roads with many randomly
> distributed sharp objects (i.e. such that age does not significantly
> change the odds of tire damage): you can keep going as long as you
> can get a flat tire fixed before another tire gets punctured. But
> sometimes, you may end up with two flat tires, and need a tow truck.
> 
I was just trying to get across the reversible nature of this kind 
of externally induced error. Richard's analogy was that scrubbing memory 
is like picking scabs. Perhaps immune reaction would be closer, because 
it tends to detect and fix small problems before they become big problems.
I don't think anybody is going to be convinced here. Sounds like the 
issue is not a lack of information. I like your car analogy - I had 
a very similar road trip between Missouri and Florida. 

Best regards,
Ed
