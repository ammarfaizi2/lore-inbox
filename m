Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132600AbRDAXwg>; Sun, 1 Apr 2001 19:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132596AbRDAXw0>; Sun, 1 Apr 2001 19:52:26 -0400
Received: from warden.digitalinsight.com ([208.29.163.2]:12973 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S132604AbRDAXwQ>; Sun, 1 Apr 2001 19:52:16 -0400
Date: Sun, 1 Apr 2001 16:43:47 -0700 (PDT)
From: David Lang <dlang@diginsite.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Manfred Spraul <manfred@colorfullife.com>,
   "Albert D. Cahalan" <acahalan@cs.uml.edu>, <lm@bitmover.com>,
   <linux-kernel@vger.kernel.org>
Subject: Re: bug database braindump from the kernel summit
In-Reply-To: <Pine.LNX.3.96.1010401183934.6155B-100000@mandrakesoft.mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0104011640280.25794-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff, my point was that not all systems will have this script. also it
won't do you any good if the system you are compiling on is not the same
system the kernel will be running on

but we are starting the wrong discussion here :-)

David Lang

On Sun, 1 Apr 2001, Jeff Garzik
wrote:

> On Sun, 1 Apr 2001, David Lang wrote:
> > On Sun, 1 Apr 2001, Jeff Garzik wrote:
> > > /sbin/installkernel copies stuff into /boot, appending a version number.
> > > One way might be to have this script also copy the kernel config.
>
> > could be, /sbin/installkernel doesn't exist on my systems
>
> arch/i386/boot/install.sh has been calling /sbin/installkernel, if it
> exists, for a good while now.
>
> It sounds like your kernel or initscripts package is incomplete.
> You can grab installkernel off a Mandrake- or RedHat-based system.
>
> 	Jeff
>
>
>
>

