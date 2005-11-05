Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751171AbVKEAIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbVKEAIb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 19:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbVKEAIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 19:08:31 -0500
Received: from ozlabs.org ([203.10.76.45]:5599 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751171AbVKEAIa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 19:08:30 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17259.63473.450876.276151@cargo.ozlabs.ibm.com>
Date: Sat, 5 Nov 2005 11:08:17 +1100
From: Paul Mackerras <paulus@samba.org>
To: Greg KH <greg@kroah.com>
Cc: linas@austin.ibm.com, linuxppc64-dev@ozlabs.org, johnrose@austin.ibm.com,
       linux-pci@atrey.karlin.mff.cuni.cz,
       bluesmoke-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/42] PCI Error Recovery for PPC64 and misc device drivers
In-Reply-To: <20051104221437.GA20004@kroah.com>
References: <20051103235918.GA25616@mail.gnucash.org>
	<20051104221437.GA20004@kroah.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH writes:

> Ok, so at first glance, I only need to pay attention to patches 15, 16,
> and 27-32?  If so, please send the ppc64 specific patches through the
> ppc64 maintainers, and the rpaphp specific patches through that specific
> maintainer.  Then care to resend the 8 remaining patches to me, so I can
> stage them in -mm for a while?

I'm happy to take care of the ppc64-specific patches.

I would *really* like to see 16 go to Linus as soon as possible, since
everything else depends on it, and since it has very little chance of
breaking any existing code.  Would you be OK with sending 16 to Linus
within the next week?

Thanks,
Paul.

