Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbUBVVcS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 16:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbUBVVcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 16:32:18 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:18645 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261752AbUBVVcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 16:32:16 -0500
Date: Sun, 22 Feb 2004 22:32:08 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Erik Tews <erik@debian.franken.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.3
Message-ID: <20040222213208.GB5499@fs.tum.de>
References: <Pine.LNX.4.58.0402172013320.2686@home.osdl.org> <20040218101702.GA5551@debian.franken.de> <20040218110232.GU1308@fs.tum.de> <20040218110933.GD5320@debian.franken.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040218110933.GD5320@debian.franken.de>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 18, 2004 at 12:09:33PM +0100, Erik Tews wrote:
> On Wed, Feb 18, 2004 at 12:02:32PM +0100, Adrian Bunk wrote:
> > On Wed, Feb 18, 2004 at 11:17:02AM +0100, Erik Tews wrote:
> > > On Tue, Feb 17, 2004 at 08:15:08PM -0800, Linus Torvalds wrote:
> > > > 
> > > > Ok, it's out.
> > > > 
> > > > There were some minimal changes relative to the last -rc4, mostly some 
> > > > configuration and build fixes, but a few important one-liners too.
> > > 
> > > Ext3 doesn't seem to compile without jbd support.
> > 
> > This is correct.
> > 
> > How did you manage to get a configuration with ext3 but without JBD?
> 
> I did not, and I did not try to do so.
> 
> There is only one menu-item to select for jbd, so there are only 2
> possible configurations. Without jbd it doesn't compile, with jbd, it
> compiles.
> 
> If you are going to make it work without jbd, you have to touch the
> source.

The only visible option is for JBD debugging support.

- Please send the complete error message.
- Please send your .config .
- Which tool did you use to create you .config?

TIA
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

