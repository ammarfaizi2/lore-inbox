Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132011AbRBNMcs>; Wed, 14 Feb 2001 07:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132066AbRBNMck>; Wed, 14 Feb 2001 07:32:40 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:34648 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S132011AbRBNMca>; Wed, 14 Feb 2001 07:32:30 -0500
Date: Wed, 14 Feb 2001 06:32:18 -0600 (CST)
From: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: Russell King <rmk@arm.linux.org.uk>,
        Rick Hohensee <humbubba@smarty.smart.net>,
        linux-kernel@vger.kernel.org
Subject: Re: dropcopyright script
In-Reply-To: <200102141231.f1ECV8202834@mobilix.ras.ucalgary.ca>
Message-ID: <Pine.LNX.3.96.1010214063149.12910a-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Feb 2001, Richard Gooch wrote:

> Jeff Garzik writes:
> > On Wed, 14 Feb 2001, Russell King wrote:
> > 
> > > Rick Hohensee writes:
> > > > .......................................................................
> > > > ## drop copyright notices to the bottoms of C files in current dir and
> > > > #     subs. 
> > > 
> > > Please don't run this on any files maintained by myself.  I want the
> > > copyright notices to be prominently displayed at the top of the file
> > > so it can't be missed.
> > 
> > Ditto.  Don't touch drivers/net either.
> 
> Sames goes for arch/i386/kernel/mtrr.c and fs/devfs.
> 
> In fact, assume the default is that people don't want this done. Get
> permission from individual maintainers. If they don't respond, don't
> touch their files. Don't ask twice.

FWIW Rick replied to me privately, saying he was only running the script
on his local files, not sending patches to Linus...

	Jeff




