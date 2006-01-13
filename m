Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422882AbWAMUAf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422882AbWAMUAf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 15:00:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422900AbWAMT77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 14:59:59 -0500
Received: from mail.kroah.org ([69.55.234.183]:4248 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1422882AbWAMT75 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 14:59:57 -0500
Date: Fri, 13 Jan 2006 11:57:15 -0800
From: Greg KH <greg@kroah.com>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Ben Collins <bcollins@ubuntu.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/15] pci: Add Toshiba PSA40U laptop to ohci1394 quirk dmi table.
Message-ID: <20060113195715.GA18869@kroah.com>
References: <0ISL00NV994G1L@a34-mta01.direcway.com> <20060111051532.GA3455@kroah.com> <200601131138.43301.jbarnes@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601131138.43301.jbarnes@virtuousgeek.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2006 at 11:38:42AM -0800, Jesse Barnes wrote:
> On Tuesday, January 10, 2006 9:15 pm, Greg KH wrote:
> > On Wed, Jan 04, 2006 at 04:59:59PM -0500, Ben Collins wrote:
> > > Signed-off-by: Ben Collins <bcollins@ubuntu.com>
> > >
> > > ---
> > >
> > >  arch/i386/pci/fixup.c |    7 +++++++
> >
> > Hm, you might want to cc: the maintainers of the sections you are
> > patching to make sure they see the change you are making.
> >
> > Care to respin this against the latest -git tree and resend it to me?
> 
> Didn't I already submit this patch?  (Checks...)  Yes, I did, and it's 
> already in the tree:
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=19272684b8e2fff39941e4c044d26ad349dd1a69

I thought so, and was also wondering about this...

Thanks for following up on it.

greg k-h
