Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751298AbVLCWvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbVLCWvH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 17:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbVLCWvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 17:51:06 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:17162 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751298AbVLCWvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 17:51:05 -0500
Date: Sat, 3 Dec 2005 23:51:05 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Greg KH <greg@kroah.com>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051203225105.GO31395@stusta.de>
References: <20051203135608.GJ31395@stusta.de> <9a8748490512030629t16d0b9ebv279064245743e001@mail.gmail.com> <20051203201945.GA4182@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051203201945.GA4182@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 03, 2005 at 12:19:45PM -0800, Greg KH wrote:
> On Sat, Dec 03, 2005 at 03:29:54PM +0100, Jesper Juhl wrote:
> > 
> > Why can't this be done by distributors/vendors?
> 
> It already is done by these people, look at the "enterprise" Linux
> distributions and their 5 years of maintance (or whatever the number
> is.)
> 
> If people/customers want stability, they already have this option.

I don't get the point where the advantage is when every distribution 
creates it's own stable branches.

AFAIR one of the reasons for the current 2.6 development model was to 
reduce the amount of feature patches distributions ship by offering an 
ftp.kernel.org kernel that gets new features early.

What's wrong with offering an unified branch with few regressions for 
both users and distributions? It's not that every distribution will use 
it, but as soon as one or two distributions are using it the amount of 
extra work for maintaining the branch should become pretty low.

> thanks,
> 
> greg k-h

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

