Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276840AbRJKT7v>; Thu, 11 Oct 2001 15:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276824AbRJKT7e>; Thu, 11 Oct 2001 15:59:34 -0400
Received: from freeside.toyota.com ([63.87.74.7]:19206 "EHLO toyota.com")
	by vger.kernel.org with ESMTP id <S276836AbRJKT7N>;
	Thu, 11 Oct 2001 15:59:13 -0400
Message-ID: <3BC5FA12.F8E5C91E@lexus.com>
Date: Thu, 11 Oct 2001 12:59:14 -0700
From: J Sloan <jjs@lexus.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tim Moore <timothymoore@bigfoot.com>
CC: linux-kernel@vger.kernel.org
Subject: [OT] Re: Which kernel (Linus or ac)?
In-Reply-To: <XFMail.20011011094548.jkp@riker.nailed.org> <3BC5E152.3D81631@bigfoot.com> <3BC5E3AF.588D0A55@lexus.com> <3BC5EB56.21B4EF88@bigfoot.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Moore wrote:

> Observations based on Roswell 2 and identical Abit BP6's: faster disk
> I/O and kernel builds (same options), smoother X11 performance (SVGA),
> higher LAN network I/O (switched LNE100TX) under heavy loads, and, none
> of the recent latency or VM issues.

You might have a pathological case there, it's
not unheard of -

But just out of curiosity, are you comparing the
stock kernel shipped with roswell, which is of
necessity safe, bland and generic, to your own
optimized, hand configured, custom compiled
2.2 kernel?

Just compiling a 2.4.9-ac by hand gave me 30%
benchmark improvement over the kernel that
shipped with roswell, so be sure to compare
apples with apples!

> As for features, I don't need any
> new feature specific to 2.4.

iptables is one biggie for me -

> I see your point but everything since 2.2.19p2 been stable for my NFS
> and app server testing needs as well as primary desktop machine.

As long as it does the job, no rush to upgrade -

I have some very busy servers running 2.2.17,
which have uptimes near 500 days - I'm in no
hurry to upgrade those - but for any new installs,
a Red Hat or Suse 2.4-based distro is the only
thing that makes any sense to me -

With all the talk about "instability" in the 2.4
series, the fact is, you run a 2.4 distro kernel
that has been painstakingly patched & brutally
QA'd the way e.g. Red Hat does, and you will
have stability.

cu

jjs

