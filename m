Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129054AbRBNMbi>; Wed, 14 Feb 2001 07:31:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129051AbRBNMb3>; Wed, 14 Feb 2001 07:31:29 -0500
Received: from h-207-228-73-44.gen.cadvision.com ([207.228.73.44]:57349 "EHLO
	mobilix.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S129054AbRBNMbQ>; Wed, 14 Feb 2001 07:31:16 -0500
Date: Wed, 14 Feb 2001 05:31:08 -0700
Message-Id: <200102141231.f1ECV8202834@mobilix.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
Cc: Russell King <rmk@arm.linux.org.uk>,
        Rick Hohensee <humbubba@smarty.smart.net>,
        linux-kernel@vger.kernel.org
Subject: Re: dropcopyright script
In-Reply-To: <Pine.LNX.3.96.1010214015928.28011A-100000@mandrakesoft.mandrakesoft.com>
In-Reply-To: <200102140755.f1E7t3W03637@flint.arm.linux.org.uk>
	<Pine.LNX.3.96.1010214015928.28011A-100000@mandrakesoft.mandrakesoft.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik writes:
> On Wed, 14 Feb 2001, Russell King wrote:
> 
> > Rick Hohensee writes:
> > > .......................................................................
> > > ## drop copyright notices to the bottoms of C files in current dir and
> > > #     subs. 
> > 
> > Please don't run this on any files maintained by myself.  I want the
> > copyright notices to be prominently displayed at the top of the file
> > so it can't be missed.
> 
> Ditto.  Don't touch drivers/net either.

Sames goes for arch/i386/kernel/mtrr.c and fs/devfs.

In fact, assume the default is that people don't want this done. Get
permission from individual maintainers. If they don't respond, don't
touch their files. Don't ask twice.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
