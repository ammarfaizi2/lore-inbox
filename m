Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269777AbRHMD1e>; Sun, 12 Aug 2001 23:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269778AbRHMD1Y>; Sun, 12 Aug 2001 23:27:24 -0400
Received: from zero.tech9.net ([209.61.188.187]:5641 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S269777AbRHMD1O>;
	Sun, 12 Aug 2001 23:27:14 -0400
Subject: Re: Hang problem on Tyan K7 Thunder resolved -- SB Live! heads-up
From: Robert Love <rml@tech9.net>
To: Nerijus Baliunas <nerijus@users.sourceforge.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
In-Reply-To: <200108122031.WAA1566356@mail.takas.lt>
In-Reply-To: <E15W1eR-000691-00@the-village.bc.nu> 
	<200108122031.WAA1566356@mail.takas.lt>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99 (Preview Release)
Date: 12 Aug 2001 23:27:23 -0400
Message-Id: <997673246.9343.3.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Aug 2001 22:30:39 +0200, Nerijus Baliunas wrote:
>> so I think Linus should do the only sane thing - back it out. I'm backing
>> it out of -ac. Of my three boxes, one spews noise, one locks up smp and
>> one works.
> 
> But later there was a patch from maintainer (Rui Sousa). Besides, there
> were no updates from maintainers for over a year, so I think
> "non maintainer" did a good thing - at least maintainers started to >
> send patches finally. Instead of backing out I suggest for maintainers
> to send more patches...

thank you :)

i think this is preferred to having a year-old revision in the kernel.

these problems (issues after Rui's update to my patch) are issues with
the driver itself, and hopefully they will be resolved now.  the number
of eyes looking at current code has grown greatly, now ...

certainly i did not intend for any issues with the driver update patch,
but some issues were fixed and many features were added (fwiw, i  have
no problems).

i suspect now the issues will be cleared up soon, and hopefully the
driver will see more frequent updates.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

