Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964784AbWHCREw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbWHCREw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 13:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932580AbWHCREw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 13:04:52 -0400
Received: from cantor2.suse.de ([195.135.220.15]:18619 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932579AbWHCREv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 13:04:51 -0400
Date: Thu, 3 Aug 2006 10:00:20 -0700
From: Greg KH <greg@kroah.com>
To: Marcel Holtmann <marcel@holtmann.org>, Neil Brown <neilb@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       stable@kernel.org
Subject: Re: [stable] Next 2.6.17-stable review cycle will be starting in about 24	hours
Message-ID: <20060803170020.GA10784@kroah.com>
References: <20060803074850.GA28301@kroah.com> <1154623652.3905.76.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1154623652.3905.76.camel@aeonflux.holtmann.net>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2006 at 06:47:32PM +0200, Marcel Holtmann wrote:
> Hi Greg,
> 
> > This is a heads up that the next 2.6.17-stable review cycle will be
> > starting in about 24 hours.  I've caught up on all pending -stable
> > patches that I know about and placed them in our queue, which can be
> > browsed online at:
> > 	http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=tree;f=queue-2.6.17
> > 
> > If anyone sees that this queue is missing something that they feel
> > should get into the next 2.6.17-stable release, please let us know at
> > stable@kernel.org within the next 24 hours or so.
> 
> instead of ext3-avoid-triggering-ext3_error-on-bad-nfs-file-handle.patch
> it makes more sense to include the revised patches from Neil:
> 
> http://comments.gmane.org/gmane.linux.kernel/430323
> 
> It seems that these are not merged upstream, but my understanding was
> that they were the best way to fix this. For RHEL4 we are going with
> these two patches. 

Hm, I just went with what Neil sent me for inclusion.  Neil, do you want
me to change the patches you sent us?

thanks,

greg k-h
