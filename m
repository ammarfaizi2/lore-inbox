Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129185AbRB1Wup>; Wed, 28 Feb 2001 17:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129306AbRB1Wuf>; Wed, 28 Feb 2001 17:50:35 -0500
Received: from [199.183.24.200] ([199.183.24.200]:48783 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S129185AbRB1WuV>; Wed, 28 Feb 2001 17:50:21 -0500
Date: Wed, 28 Feb 2001 17:50:09 -0500
From: Peter Zaitcev <zaitcev@redhat.com>
To: ted@cypress.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB oops Linux 2.4.2ac6
Message-ID: <20010228175009.A27630@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 2.4.2-ac6 
> > o USB hub kmalloc wrong size corruption fix (Peter Zaitcev) 

> The first line of the oops is 
> 
> ----
> kernel BUG at slab.c:1398!
> ----
> Any other ideas to try?
>         -Thomas

I did not break it, honest! I will be looking in a USB mouse
problem though. If you need an immediate resolution, nice
folks at linux-usb@lists.sourceforge.net may be able to help.
Or may be not :)

-- Pete
