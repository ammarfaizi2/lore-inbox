Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280733AbRKYFh6>; Sun, 25 Nov 2001 00:37:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280736AbRKYFhh>; Sun, 25 Nov 2001 00:37:37 -0500
Received: from lsmls02.we.mediaone.net ([24.130.1.15]:28903 "EHLO
	lsmls02.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S280733AbRKYFhb>; Sun, 25 Nov 2001 00:37:31 -0500
Message-ID: <3C0083A2.A817BFE@kegel.com>
Date: Sat, 24 Nov 2001 21:37:38 -0800
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: David Relson <relson@osagesoftware.com>, stp@osdlab.org
Subject: re: Kernel Releases
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Relson <relson@osagesoftware.com> wrote:
> With the recent problems, the working 
> versions tend to be the -pre1 or -pre2 releases, not the released 
> one.  With a bit of QA, I think we can have 2.4.x releases be the stable 
> releases.  Here's how...
> 
> When the kernel maintainer, now Marcelo for 2.4, is ready to release the 
> next kernel, for example 2.4.16, I suggest he switch from "pre?" to "-rc1" 
> (as in release candidate).  A day or two with -rc1 will quickly show if it 
> has a show stopper.  If so, then the minor fixes (and nothing else) go into 
> -rc2.  A day or two ..., and either -rc3 appears or we have a stable 
> release and 2.4.16 is ready to be released.
> 
> Let's go the extra distance and have the releases be usable, stable 
> kernels!  It's what users want and it's within the abilities of the 
> developers to produce.  Let's do it :-)

Hear, hear!  

Also, Marcelo should get in touch with the nice folks at stp@osdlab.org
and find out what sort of regression tests they will be running on
his kernels.  Perhaps he can wait for their feedback on the -rcX
kernels before declaring them final.  (Not that they would have
found the 2.4.15 problem with their current tests, but they'll
catch a few things.)

- Dan
