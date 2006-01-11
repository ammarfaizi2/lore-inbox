Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932545AbWAKA34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932545AbWAKA34 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 19:29:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932546AbWAKA34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 19:29:56 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:12812 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932545AbWAKA3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 19:29:55 -0500
Date: Wed, 11 Jan 2006 01:29:54 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: State of the Union: Wireless
Message-ID: <20060111002954.GI3911@stusta.de>
References: <43C3AAE2.1090900@cubic.ch> <mailman.1136898727.7233.linux-kernel2news@redhat.com> <20060110160324.17074fa3.zaitcev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060110160324.17074fa3.zaitcev@redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2006 at 04:03:24PM -0800, Pete Zaitcev wrote:
> On Tue, 10 Jan 2006 13:53:57 +0100, Adrian Bunk <bunk@stusta.de> wrote:
> > On Tue, Jan 10, 2006 at 01:38:58PM +0100, Tim Tassonis wrote:
> > >...
> > > >We can always undo mistakes later, but 
> > > >we'll never get to that point if we don't start moving in one direction 
> > > >instead of ten.
> > > 
> > > You were right if there were ten, but there seem to be only two at the 
> > > moment. One stack will survive and one will die. There's no point in 
> > > deciding this now.
> > 
> > No, we'll end up with two stacks, some drivers using the first stack and 
> > some the second one.
> > 
> > You can't simply let one stack die because this would imply either 
> > rewriting all drivers using this stack or dropping support for some 
> > hardware.
> 
> So, you don't want to remove OSS drivers anymore, I take it.
> Can't let bad stacks die!

There are OSS drivers in the kernel that support hardware not supported 
by ALSA.

> -- Pete

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

