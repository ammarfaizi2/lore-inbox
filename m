Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261304AbVFBVEk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbVFBVEk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 17:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261289AbVFBVCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 17:02:50 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:17590 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S261331AbVFBU6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 16:58:43 -0400
Date: Thu, 2 Jun 2005 13:58:41 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][1/3] RapidIO support: core
Message-ID: <20050602135841.A24818@cox.net>
References: <20050601110836.A16559@cox.net> <20050602000050.GA5678@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050602000050.GA5678@kroah.com>; from greg@kroah.com on Wed, Jun 01, 2005 at 05:00:50PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2005 at 05:00:50PM -0700, Greg KH wrote:
> On Wed, Jun 01, 2005 at 11:08:36AM -0700, Matt Porter wrote:
> > Adds a RapidIO subsystem to the kernel. RIO is a switched
> > fabric interconnect used in higher-end embedded applications.

<snip>

> > The curious can look at the specs over at http://www.rapidio.org
> > Patch is 108KB and can be found here:
> > ftp://source.mvista.com/pub/rio/l26_rio_core.patch
> 
> Care to split it up into logical sections and post it?  It should be
> small enough to do so that way.

Ok.

My gut told me to not trust SubmittingPatches but I did it anyway. :)
A new 5 part patch series is going out now with current comments 
incorporated.

-Matt
