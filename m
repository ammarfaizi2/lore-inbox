Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279496AbRJXIxs>; Wed, 24 Oct 2001 04:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279497AbRJXIxh>; Wed, 24 Oct 2001 04:53:37 -0400
Received: from 203-109-153-116.static.ihug.co.nz ([203.109.153.116]:52885 "EHLO
	umbra") by vger.kernel.org with ESMTP id <S279496AbRJXIxa>;
	Wed, 24 Oct 2001 04:53:30 -0400
Date: Wed, 24 Oct 2001 21:56:21 +1300
From: Tim Nicholas <cilix@lsd.net.nz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.13..
Message-ID: <20011024215621.A28809@nicholas.net.nz>
In-Reply-To: <Pine.LNX.4.33.0110232249090.1185-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0110232249090.1185-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Oct 23, 2001 at 10:52:28PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all, 
I seem to be having serious issues with 2.4.13.
After recompiling and rebooting everything seemed to work fine, but
after having a break to watch Buffy, things seemed to stop
working... 

Every time i tried to do anything i got the same error....

Inconsistency detected by ld.so: dynamic-link.h: 62: elf_get_dynamic_info: Assertion `! "bad dynamic tag"' failed!

I am assuming that this is a very bad thing? It stopped me from doing
anything much. Processes which were already running seemed to be
fine (I was in KDE with mozilla and XMMS running), but other things
like 'w' and ppp no longer worked. I also couldn't reboot cleanly by
using Ctrl+Alt+del.
The problem wasn't happening straight away, but after somewhere
between 10 and 70 minutes of uptime.... 

Am I the only one? I am running a Tbird 900 with 128MB RAM,
debian-unstable. The same kernel configuration (updated with make
oldconfig) worked absolutely fine with 2.4.12.


Yours, 

Tim Nicholas

On Tue, Oct 23, 2001 at 10:52:28PM -0700, Linus Torvalds wrote:
> 
> Things seem to be calming down a bit, which is nice.
> 
> Of course, it might possibly also be that everybody is off flaming about
> the DMCA and getting no work done ;)
> 
> Whatever the cause, here's a 2.4.13. See if you can break it,
> 
> 		Linus
> 
--
Tim Nicholas                          ||                      Cilix
Email: cilix@lsd.net.nz               ||              ICQ# 15869961
http://tim.nicholas.net.nz/           ||                Dunedin, NZ
Cell phone# +64 21 113 0399           || Home phone# +64 3 471 8415
