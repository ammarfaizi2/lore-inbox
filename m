Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262424AbSI2JPm>; Sun, 29 Sep 2002 05:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262426AbSI2JPm>; Sun, 29 Sep 2002 05:15:42 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:20644 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262424AbSI2JPk>;
	Sun, 29 Sep 2002 05:15:40 -0400
Date: Sun, 29 Sep 2002 11:15:39 +0200
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ingo Molnar <mingo@elte.hu>, Jeff Garzik <jgarzik@pobox.com>,
       Larry Kessler <kessler@us.ibm.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       "Andrew V. Savochkin" <saw@saw.sw.com.sg>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Richard J Moore <richardj_moore@uk.ibm.com>
Subject: Re: v2.6 vs v3.0
Message-ID: <20020929091539.GB1014@suse.de>
References: <Pine.LNX.4.44.0209280934540.13549-100000@localhost.localdomain> <Pine.LNX.4.44.0209281826050.2198-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209281826050.2198-100000@home.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 28 2002, Linus Torvalds wrote:
> 
> On Sat, 28 Sep 2002, Ingo Molnar wrote:
> > 
> > i consider the VM and IO improvements one of the most important things
> > that happened in the past 5 years - and it's definitely something that
> > users will notice. Finally we have a top-notch VM and IO subsystem (in
> > addition to the already world-class networking subsystem) giving
> > significant improvements both on the desktop and the server - the jump
> > from 2.4 to 2.5 is much larger than from eg. 2.0 to 2.4.
> 
> Hey, _if_ people actually are universally happy with the VM in the current
> 2.5.x tree, I'll happily call the dang thing 5.0 or whatever (just
> kidding, but yeah, that would be a good enough reason to bump the major
> number).

Works For Me, at _least_ as well as 2.4.20-pre kernels. On my desktop
machine it feels better. After a few days of uptime it's fairly easy to
feel how well a kernel performs for that workload. And 2.5.39 is just
smoother than current 2.4.

> The block IO cleanups are important, and that was the major thing _I_ 
> personally wanted from the 2.5.x tree when it was opened. I agree with you 
> there. But I don't think they are major-number-material.

Dang :-)

--
Jens Axboe, rooting for 3.x

