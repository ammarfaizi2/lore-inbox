Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750988AbVKEA3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbVKEA3N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 19:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbVKEA3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 19:29:13 -0500
Received: from mail.kroah.org ([69.55.234.183]:40650 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750988AbVKEA3M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 19:29:12 -0500
Date: Fri, 4 Nov 2005 16:28:43 -0800
From: Greg KH <greg@kroah.com>
To: Paul Mackerras <paulus@samba.org>
Cc: linas@austin.ibm.com, linuxppc64-dev@ozlabs.org, johnrose@austin.ibm.com,
       linux-pci@atrey.karlin.mff.cuni.cz,
       bluesmoke-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/42] PCI Error Recovery for PPC64 and misc device drivers
Message-ID: <20051105002842.GB22574@kroah.com>
References: <20051103235918.GA25616@mail.gnucash.org> <20051104221437.GA20004@kroah.com> <17259.63473.450876.276151@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17259.63473.450876.276151@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 05, 2005 at 11:08:17AM +1100, Paul Mackerras wrote:
> Greg KH writes:
> 
> > Ok, so at first glance, I only need to pay attention to patches 15, 16,
> > and 27-32?  If so, please send the ppc64 specific patches through the
> > ppc64 maintainers, and the rpaphp specific patches through that specific
> > maintainer.  Then care to resend the 8 remaining patches to me, so I can
> > stage them in -mm for a while?
> 
> I'm happy to take care of the ppc64-specific patches.
> 
> I would *really* like to see 16 go to Linus as soon as possible, since
> everything else depends on it, and since it has very little chance of
> breaking any existing code.  Would you be OK with sending 16 to Linus
> within the next week?

Can I take 15, 16, 27-32 now without the ppc64 patches dying without it?

thanks,

greg k-h
