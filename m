Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264262AbTLJXFW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 18:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264266AbTLJXFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 18:05:21 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:49675
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S264262AbTLJXFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 18:05:09 -0500
Date: Wed, 10 Dec 2003 14:59:10 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Linus Torvalds <torvalds@osdl.org>, Maciej Zenczykowski <maze@cela.pl>,
       David Schwartz <davids@webmaster.com>,
       Jason Kingsland <Jason_Kingsland@hotmail.com>,
       linux-kernel@vger.kernel.org
Subject: RE: Linux GPL and binary module exception clause?
In-Reply-To: <Pine.LNX.4.58.0312102212370.1125@earth>
Message-ID: <Pine.LNX.4.10.10312101449260.3805-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo,

I suggest asking FSF how they play with GPL+another license.
They will tell you GPL can not co-exist, period.

The reply is a double bounce back of ideas.

Jason,

What you are really saying is the Linux does not have a GPL license.
It has a GPL-like or LKL.

Linux Kernel License.

Hmmm, new thought ...

I will be kind to it because it is in a strange place :-)

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Wed, 10 Dec 2003, Ingo Molnar wrote:

> 
> On Wed, 10 Dec 2003, Andre Hedrick wrote:
> 
> > I have and the lawyers tell me that it is one or the other and can not
> > be both.  So explain to me how a GPL/BSD or BSD/GPL works again?
> 
> ugh. Are your lawyers saying that the tons of dual-licensed code is not a
> valid license? Seems like your lawyers disagree with lots of other
> lawyers.
> 
> > Also if one does an md5sum on the "COPYING" file from FSF and compares
> > it from the one in the kernel source they differ.
> 
> here's the (trivial) diff. Draw your own conclusions.
> 
> --- libc/COPYING	2001-07-06 07:57:07.000000000 +0200
> +++ v/COPYING	2003-11-23 13:21:58.000000000 +0100
> @@ -1,3 +1,19 @@
> +
> +   NOTE! This copyright does *not* cover user programs that use kernel
> + services by normal system calls - this is merely considered normal use
> + of the kernel, and does *not* fall under the heading of "derived work".
> + Also note that the GPL below is copyrighted by the Free Software
> + Foundation, but the instance of code that it refers to (the Linux
> + kernel) is copyrighted by me and others who actually wrote it.
> +
> + Also note that the only valid version of the GPL as far as the kernel
> + is concerned is _this_ particular version of the license (ie v2, not
> + v2.2 or v3.x or whatever), unless explicitly otherwise stated.
> +
> +			Linus Torvalds
> +
> +----------------------------------------
> +
>  		    GNU GENERAL PUBLIC LICENSE
>  		       Version 2, June 1991
>  
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

