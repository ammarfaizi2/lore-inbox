Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752153AbWKBV0F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752153AbWKBV0F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 16:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752626AbWKBV0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 16:26:05 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:39688 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1752628AbWKBV0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 16:26:03 -0500
Date: Thu, 2 Nov 2006 22:26:02 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Laurent Riffard <laurent.riffard@free.fr>,
       Rajesh Shah <rajesh.shah@intel.com>, toralf.foerster@gmx.de,
       Jeff Garzik <jeff@garzik.org>, Pavel Machek <pavel@ucw.cz>,
       Greg KH <greg@kroah.com>
Subject: Re: 2.6.19-rc4: known unfixed regressions
Message-ID: <20061102212602.GI27968@stusta.de>
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org> <20061031195654.GV27968@stusta.de> <200611022102.02302.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611022102.02302.rjw@sisk.pl>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2006 at 09:02:01PM +0100, Rafael J. Wysocki wrote:
> Hi,

Ji Rafael,

> On Tuesday, 31 October 2006 20:56, you wrote:
> > This email lists some known regressions in 2.6.19-rc4 compared to 2.6.18
> > that are not yet fixed in Linus' tree.
> 
> Can we please add the following two to the list of known regressions:
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=7082
> http://bugzilla.kernel.org/show_bug.cgi?id=7207
> 
> They are regressions with respect to 2.6.17.x kernels, but still.
>...

I'm sorry, but I'm only tracking regressions since 2.6.18 - "regressions 
since the latest stable kernel" is a clear border, and the number of 
post-2.6.18 regressions is high enough that adding even more 
regressions to my list wouldn't make sense.

> Greetings,
> Rafael

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

