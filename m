Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262630AbUKXMxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262630AbUKXMxz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 07:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262632AbUKXMxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 07:53:54 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:7857 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262630AbUKXMxx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 07:53:53 -0500
Date: Wed, 24 Nov 2004 13:53:20 +0100
From: Jens Axboe <axboe@suse.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: "O.Sezer" <sezeroz@ttnet.net.tr>, linux-kernel@vger.kernel.org
Subject: Re: status of cdrom patches for 2.4 ?
Message-ID: <20041124125319.GB13847@suse.de>
References: <41A3C391.8070609@ttnet.net.tr> <20041124074336.GB8718@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041124074336.GB8718@logos.cnet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24 2004, Marcelo Tosatti wrote:
> On Wed, Nov 24, 2004 at 01:11:13AM +0200, O.Sezer wrote:
> > Hi all:
> > 
> > What are the status of the cdrom patches for 2.4 series?
> > Namely the dvd patches which are dropped while in the
> > 27-rc era, and the cd-mrw patch which never had a chance
> > trying to go in to 2.4. Jens? Mancelo?
> 
> There were problems with the DVD-RW patches so I reverted them.
> 
> Jens, what do you think?

I don't think it's worth the bother, the support is in 2.6. And I don't
want to maintain new atapi stuff for 2.4. Pat used to care about the
patches, but as he is no longer with Iomega I don't think there's anyone
to look after it.

-- 
Jens Axboe

