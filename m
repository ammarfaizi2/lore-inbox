Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751790AbWIYBXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751790AbWIYBXY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 21:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751794AbWIYBXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 21:23:24 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:4617 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751790AbWIYBXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 21:23:23 -0400
Date: Mon, 25 Sep 2006 03:23:22 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: Willy Tarreau <w@1wt.eu>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.16.30-pre1
Message-ID: <20060925012322.GE4547@stusta.de>
References: <20060922222300.GA5566@stusta.de> <20060922223859.GB21772@kroah.com> <20060922224735.GB5566@stusta.de> <20060922230928.GB22830@kroah.com> <20060923045610.GM541@1wt.eu> <20060923232150.GK5566@stusta.de> <20060924101753.GB4813@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060924101753.GB4813@ucw.cz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 24, 2006 at 10:17:53AM +0000, Pavel Machek wrote:
> Hi!
> 
> > > Adrian, when you have a doubt whether such a fix should go into next
> > > release, simply tell people about the problem and ask them to test
> > > current driver. If nobody encounters the problem, you can safely keep
> > > the patch in your fridge until someone complains. By that time, the
> > > risks associated with this patch will be better known.
> > 
> > It's not that I wanted to upgrade ACPI to the latest version.
> > 
> > And my rules are:
> > - patch must be in Linus' tree
> > - I'm asking the patch authors and maintainers of the affected subsystem
> >   whether the patch is OK for 2.6.16
> 
> I thought stable rules were longer than this... including 'patch must
> be < 100 lines' and 'must be bugfix for serious bug'. Changing rules
> for -stable series in the middle of it seems like a bad idea...

I stated what I'd do with 2.6.16 before I took over maintainance.

> Maybe you can keep -ab with relaxed rules and -stable with original
> rules?

Much would be possible under the assumption I had unlimited time...

> 							Pavel

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

