Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269866AbRHIVmj>; Thu, 9 Aug 2001 17:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270596AbRHIVma>; Thu, 9 Aug 2001 17:42:30 -0400
Received: from ns.cablesurf.de ([195.206.131.193]:6795 "EHLO ns.cablesurf.de")
	by vger.kernel.org with ESMTP id <S269866AbRHIVmT>;
	Thu, 9 Aug 2001 17:42:19 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
To: Andreas Dilger <adilger@turbolinux.com>
Subject: Re: using bug reports on vendor kernels
Date: Thu, 9 Aug 2001 23:42:38 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <200108092131.f79LV4Hr024656@webber.adilger.int>
In-Reply-To: <200108092131.f79LV4Hr024656@webber.adilger.int>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01080923423801.04822@idun>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag,  9. August 2001 23:31 schrieben Sie:
> Oliver writes:
> > is there a site that would allow me to browse a list of patches added to
> > vendor kernels (esp. RedHat). I need this to use an oops supplied by a
> > user.
>
> You _should_ be able to simply get the RedHat source RPM, and have a look
> at the various patches that are applied to the base Linus kernel.  At least
> that is how the Turbolinux and SuSE kernels are built (haven't looked
> at a RedHat kernel in a while, but I expect the same).  Granted, some
> of the patch names are not exactly self explanitory (e.g. jumbo patches
> like -ac or -aa, which have their own documentation somewhere, often l-k).

It might do so. However the speed of my internet connectivity would make this 
a very, very slow task.
And the day after having completed that I'd be bound to get a bug report from 
a Mandrake user.

	Regards
		Oliver
