Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265791AbSKAWT3>; Fri, 1 Nov 2002 17:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265792AbSKAWT3>; Fri, 1 Nov 2002 17:19:29 -0500
Received: from adsl-67-120-62-187.dsl.lsan03.pacbell.net ([67.120.62.187]:1294
	"EHLO exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S265791AbSKAWT2>; Fri, 1 Nov 2002 17:19:28 -0500
Message-ID: <11E89240C407D311958800A0C9ACF7D1A33C8E@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'Richard B. Johnson'" <root@chaos.analogic.com>
Cc: Ken Ryan <newsryan@leesburg-geeks.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [STATUS 2.5] October 30, 2002
Date: Fri, 1 Nov 2002 14:25:55 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, November 01, 2002 at 11:56 AM, Richard B. Johnson wrote:
> [...]
> So, ten seconds after you have some cosmic-ray upset, you guarantee
> that your machine will crash if you read everything every ten
> seconds. This will never be acceptable. You need to leave the
> machine alone and not try to "pick scabs". That's how you get
> the best reliability. Also, at some periodic intervals, you
> re-boot (restart) the whole machine, reinitializing everything
> including all the RAM.
> 
Here's a Monty Python analogy to ECC memory scrubbing:

Do you remember the battle between Arthur and the Black Knight? 

Without scrubbing, the memory bits suffer damage at a more or less constant
rate, like the Black Knight. The damage accumulates and eventually renders
the  Black Knight non-functional. For the memory, this would be an
uncorrectable error from the accumulation of many separate bit error events.

With scrubbing, the memory bits and the Black Knight suffer damage at the
same rate, but this time the Black Knight is able to stick his limbs back on
(while fighting) after Arthur hacks them off. If the Black Knight's rate of
sticking his limbs back on equals Arthur's rate of hacking his limbs off,
the Black Knight will sustain the same amount of damage, but will remain
functional as long as he can keep up. For the memory, the many separate bit
error events would cause only correctable errors, as long as the scrubbing
can keep up.

cheers,
Ed
