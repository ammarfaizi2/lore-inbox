Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932588AbWBSOyo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932588AbWBSOyo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 09:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932590AbWBSOyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 09:54:44 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:20747 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932588AbWBSOyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 09:54:43 -0500
Date: Sun, 19 Feb 2006 15:54:42 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Pekka Enberg <penberg@cs.helsinki.fi>, Robert Love <rml@novell.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       John Stultz <johnstul@us.ibm.com>, gregkh@suse.de
Subject: Re: 2.6.16-rc4: known regressions
Message-ID: <20060219145442.GA4971@stusta.de>
References: <Pine.LNX.4.64.0602171438050.916@g5.osdl.org> <20060217231444.GM4422@stusta.de> <84144f020602190306o3149d51by82b8ccc6108af012@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84144f020602190306o3149d51by82b8ccc6108af012@mail.gmail.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 19, 2006 at 01:06:45PM +0200, Pekka Enberg wrote:
> On 2/18/06, Adrian Bunk <bunk@stusta.de> wrote:
> > Subject    : gnome-volume-manager broken on powerpc since 2.6.16-rc1
> > References : http://bugzilla.kernel.org/show_bug.cgi?id=6021
> > Submitter  : John Stultz <johnstul@us.ibm.com>
> > Status     : still present in -git two days ago
> 
> This is not ppc only. I have the exact same problem on Gentoo
> Linux/x86. No ipod events on 2.6.16-rc1, whereas 2.6.15 works fine.
> Haven't had the time to investigate further yet, sorry.

Thanks for this information.

Robert, can you look at this problem?

>                           Pekka

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

