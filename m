Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262281AbTEFCtl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 22:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262288AbTEFCtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 22:49:41 -0400
Received: from munk.apl.washington.edu ([128.95.96.184]:52166 "EHLO
	munk.apl.washington.edu") by vger.kernel.org with ESMTP
	id S262281AbTEFCtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 22:49:39 -0400
Date: Mon, 5 May 2003 20:19:11 -0700 (PDT)
From: Brian Dushaw <dushaw@apl.washington.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: Albatron KM18G PRO/RedHat 9.0 - disk errors and system seizures...
Message-ID: <Pine.LNX.4.44.0305052017190.27270-100000@munk.apl.washington.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 May 2003, Brad Laue wrote:

> Brian Dushaw wrote:
> >     I've installed RedHat 9.0 three times now - going on the fourth.  Most
> > recently I upgraded the kernel with the RedHat update, to similar effect.  The
> > problem seems to be two fold:  system lockups and disk errors. 
> 
> The RedHat kernel is massively modified, especially in version 9.0 of 
> the distribution. Try a vanilla kernel and see if the system continues 
> to misbehave.

A fourth install...

I've tried the 2.4.21-rc1-acX kernel (after trials and tribulations with
RedHat - the compilation kept segmentation faulting).  This seems to be
somewhat more stable, but still unstable.  Sorry to be vague, but if I could
be more specific I could probably solve the problem...  I still get X-windows/
system seizures, although I can't say I have any disk errors now  (except 
perhaps for those caused by the lockups.)  I am going to try an offboard
video card to see if that helps (the onboard video apparently uses system
ram for its memory - I don't know if this makes a difference to linux or not).

I tried using only one memory card, which did not solve the problem (i.e.,
twin bank memory is not the problem).

Disk access is about twice as fast (~60 MB/s by hdparm -tT) now with the new 
kernel, if only the system were stable!  I watched Lawrence of Arabia on 
DVD (3.5 hr movie) with this same system in Win2K without a problem, so the 
problem would appear to be linux OS specific.

Still trolling for advice, thanks, 

B.D.



