Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266405AbUAIAxI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 19:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266408AbUAIAxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 19:53:08 -0500
Received: from [193.138.115.2] ([193.138.115.2]:53513 "HELO
	diftmgw.backbone.dif.dk") by vger.kernel.org with SMTP
	id S266405AbUAIAxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 19:53:03 -0500
Date: Fri, 9 Jan 2004 01:48:22 +0100 (CET)
From: Jesper Juhl <juhl@dif.dk>
To: Gene Heskett <gene.heskett@verizon.net>
cc: Dave Jones <davej@redhat.com>, Samuel Flory <sflory@rackable.com>,
       Maciej Zenczykowski <maze@cela.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Howto use diff compatibly
In-Reply-To: <200401081913.25073.gene.heskett@verizon.net>
Message-ID: <Pine.LNX.4.56.0401090145210.10911@jju_lnx.backbone.dif.dk>
References: <Pine.LNX.4.44.0401082300421.1739-100000@gaia.cela.pl>
 <3FFDDF0C.7080307@rackable.com> <20040108231722.GC20616@redhat.com>
 <200401081913.25073.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 8 Jan 2004, Gene Heskett wrote:

> On Thursday 08 January 2004 18:17, Dave Jones wrote:
> >On Thu, Jan 08, 2004 at 02:51:56PM -0800, Samuel Flory wrote:
> > >   That would be the maintainer for drivers/ide/ide-floppy.c.  I
> > > don't think there is a maintainer for drivers/block/floppy.c.
> >
> >floppy.c is one of those 'last person who touched it' hot-potatoes
> > 8-)
> >
> >		Dave
>
> Humm, precisely what I was afraid of...  And I don't want to 'adopt'
> that puppy, not knowing near enough about it to be able to address
> every potential problem.
>

Why don't you post the patch and see what reactions it generates? If
you've got some good code it would be a shame not to see it used.
On the other hand, if it turns out not to be good, then the easiest
way to find that out is for people to get a chance to look at it and
pull it apart...
Discussions of puppy 'adoptions' could come later ;)


-- Jesper Juhl

