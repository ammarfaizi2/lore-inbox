Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261484AbTIOPwU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 11:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261489AbTIOPwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 11:52:20 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:61914 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261484AbTIOPwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 11:52:19 -0400
Date: Mon, 15 Sep 2003 17:52:12 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: isdn4linux@listserv.isdn4linux.de,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test5: ISDN kcapi.c no longer compiles
Message-ID: <20030915155212.GJ126@fs.tum.de>
References: <Pine.LNX.4.44.0309081319380.1666-100000@home.osdl.org> <20030910165742.GG27368@fs.tum.de> <20030915065734.GA5134@pingi3.kke.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030915065734.GA5134@pingi3.kke.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 15, 2003 at 08:57:34AM +0200, Karsten Keil wrote:
> On Wed, Sep 10, 2003 at 06:57:42PM +0200, Adrian Bunk wrote:
> > On Mon, Sep 08, 2003 at 01:32:05PM -0700, Linus Torvalds wrote:
> > >...
> > > Summary of changes from v2.6.0-test4 to v2.6.0-test5
> > > ============================================
> > >...
> > > Karsten Keil:
> > >...
> > >   o next fixes
> > >...
> > 
> > It seems this change broke the compilation of kcapi.c:
> > 
> 
> Ah, with your .config now it's clear what was broken: none MODULE compile
>...
> This should fix it.

Thanks, your patch fixed the compilation.

> Karsten Keil

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

