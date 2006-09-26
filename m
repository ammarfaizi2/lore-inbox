Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964783AbWIZUXW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964783AbWIZUXW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 16:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964784AbWIZUXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 16:23:22 -0400
Received: from ns2.suse.de ([195.135.220.15]:33749 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964783AbWIZUXV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 16:23:21 -0400
Date: Tue, 26 Sep 2006 13:23:03 -0700
From: Greg KH <greg@kroah.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, Jim Paradis <jparadis@redhat.com>,
       Andi Kleen <ak@suse.de>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86[-64] PCI domain support
Message-ID: <20060926202303.GA15369@kroah.com>
References: <20060926191508.GA6350@havoc.gtf.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060926191508.GA6350@havoc.gtf.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2006 at 03:15:08PM -0400, Jeff Garzik wrote:
> 
> The x86[-64] PCI domain effort needs to be restarted, because we've got
> machines out in the field that need this in order for some devices to
> work.
> 
> RHEL is shipping it now, apparently without any problems.
> 
> The 'pciseg' branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/misc-2.6.git pciseg

So are the NUMA issues now taken care of properly?  If so, care to send
me the patches for this so I can add them to my quilt tree?

thanks,

greg k-h
