Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132577AbRDAXcg>; Sun, 1 Apr 2001 19:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132584AbRDAXc1>; Sun, 1 Apr 2001 19:32:27 -0400
Received: from warden.digitalinsight.com ([208.29.163.2]:1192 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S132577AbRDAXcK>; Sun, 1 Apr 2001 19:32:10 -0400
Date: Sun, 1 Apr 2001 16:25:16 -0700 (PDT)
From: David Lang <dlang@diginsite.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Manfred Spraul <manfred@colorfullife.com>,
   "Albert D. Cahalan" <acahalan@cs.uml.edu>, <lm@bitmover.com>,
   <linux-kernel@vger.kernel.org>
Subject: Re: bug database braindump from the kernel summit
In-Reply-To: <Pine.LNX.3.96.1010401181724.28121i-100000@mandrakesoft.mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0104011618540.25794-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff, if the sysadmin had anything to do with setting up the box I would
agree with you, but there are cases where one person will boot a machine
and another will then need to find out what is going on.

I have seen systems with multiple kernels available on boot get booted
from the wrong kernel

I've also seen a machine running for years without being touched and then
a sysadmin is hired and has to work on it, how should they know what the
config was?

/proc/config may be bloat, but we do need a way for the kernel config to
be tied to the kernel image that is running, however it is made available.

David Lang

 On Sun, 1 Apr
2001, Jeff Garzik wrote:

>
> If a sysadmin (note I don't say "user") has no clue what his kernel
> config is, or has no clue what kernel is running on his box, then
> they should be fired before the day is out.
>
> 	Jeff
>
>
>

