Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268506AbUIGT64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268506AbUIGT64 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 15:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268537AbUIGTwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 15:52:17 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:1807 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S268506AbUIGTnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 15:43:18 -0400
Date: Tue, 7 Sep 2004 21:42:47 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, ". Sam Ravnborg" <sam@ravnborg.org>,
       Ian Wienand <ianw@gelato.unsw.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.6.9-rc1-mm4: small LOCALVERSION help text corrections
Message-ID: <20040907194246.GF2454@fs.tum.de>
References: <20040907020831.62390588.akpm@osdl.org> <20040907184314.GA2454@fs.tum.de> <20040907212716.GB6053@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040907212716.GB6053@mars.ravnborg.org>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2004 at 11:27:16PM +0200, Sam Ravnborg wrote:
>...
> > --- linux-2.6.9-rc1-mm4-full/init/Kconfig.old	2004-09-07 20:36:13.000000000 +0200
> > +++ linux-2.6.9-rc1-mm4-full/init/Kconfig	2004-09-07 20:37:15.000000000 +0200
> > @@ -311,13 +311,13 @@
> >  config LOCALVERSION
> >  	string "Local Version"
> >  	help
> >  	  Append an extra string to the end of your kernel version.
> >  	  This will show up when you type uname, for example.
> > -	  The string you set here will be appended after the contents of=20
> > -	  any files with a filename matching localversion* in your=20
> > -	  object and source tree, in that order.  Your total string can
> > +	  The string you set here will be appended after the contents of
> > +	  any files with a filename matching localversion* in your
> > +	  object and source trees, in that order.  Your total string can
> >  	  be a maximum of 64 characters.
> 
> Would it make sense to move this item further up in this menu?
> I would prefer at the top, but at least before "Embedded"

Sounds reasonable.

> 	Sam

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

