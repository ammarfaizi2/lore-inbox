Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751231AbWFTV4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbWFTV4R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 17:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbWFTV4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 17:56:17 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:44758 "EHLO
	palinux.external.hp.com") by vger.kernel.org with ESMTP
	id S1751221AbWFTV4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 17:56:16 -0400
Date: Tue, 20 Jun 2006 15:56:15 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Jeff Garzik <jeff@garzik.org>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-scsi <linux-scsi@vger.kernel.org>
Subject: Re: [GIT PATCH] SCSI updates for 2.6.17
Message-ID: <20060620215615.GN1630@parisc-linux.org>
References: <1150837947.2531.27.camel@mulgrave.il.steeleye.com> <449866E3.8010200@garzik.org> <449867D2.3020909@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <449867D2.3020909@garzik.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2006 at 05:25:38PM -0400, Jeff Garzik wrote:
> Jeff Garzik wrote:
> >James Bottomley wrote:
> >>This represents the almost complete SCSI pending list apart from a SAS
> >>port update which we're still trying to beat into shape.  The patch can
> >>be pulled from here:
> >
> >When will aic94xx head upstream?  Even though it is seeing changes in 
> >your repo, I would rather not hide the driver for another six months.
> >
> >aic94xx is the only all-software-stack SAS user at present, so I think 
> >its reasonable to get it into the tree, and make changes upstream.
> 
> I should have also mentioned the "it works" characteristic that aic94xx 
> continues to have.

Like the parisc patches to Tulip, you mean?  Glad to know they finally
have the Jeff Garzik Seal of Approval.

