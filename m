Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262402AbSKCTeJ>; Sun, 3 Nov 2002 14:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262430AbSKCTeI>; Sun, 3 Nov 2002 14:34:08 -0500
Received: from amsfep14-int.chello.nl ([213.46.243.22]:22346 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id <S262402AbSKCTca>; Sun, 3 Nov 2002 14:32:30 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jos Hulzink <josh@stack.nl>
To: Vojtech Pavlik <vojtech@suse.cz>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Petition against kernel configuration options madness...
Date: Sun, 3 Nov 2002 22:39:10 +0100
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <200211031809.45079.josh@stack.nl> <3DC56270.8040305@pobox.com> <20021103200704.A8377@ucw.cz>
In-Reply-To: <20021103200704.A8377@ucw.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211032239.10843.josh@stack.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 03 November 2002 20:07, Vojtech Pavlik wrote:
> On Sun, Nov 03, 2002 at 12:52:48PM -0500, Jeff Garzik wrote:

> > Unfortunately I don't have any concrete suggestions for Vojtech (input
> > subsystem maintainer), just a request that it becomes easier and more
> > obvious how to configure the keyboard and mouse that is found on > 90%
> > of all Linux users computers [IMO]...
>
> Too bad you don't have any suggestions. I completely agree this should
> be simplified, while I wouldn't be happy to lose the possibility of not
> compiling AT keyboard support in.

Something I have been thinking about for a while is a quick-config option 
(that sets some defaults that hold for 90% of the systems), or an expert mode 
that shows extra options. Though I understand that this is hard to do, and 
much hardware differs, I think it can be done for some basics like keyboard, 
mouse, USB and stuff.

Yes, this will cause your kernel to be bigger than optimal, for some drivers 
will be compiled in that are not used on your system. But if you want you can 
optimize things away after clicking <set defaults for standard IBM PC>.

If this idea is not blown away immediately, I'm willing to work this idea out 
a little, though I can understand that people call me an idiot...

Jos


