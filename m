Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261703AbVANBxL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261703AbVANBxL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 20:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbVANBuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 20:50:22 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:58382
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261382AbVANBtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 20:49:13 -0500
Date: Fri, 14 Jan 2005 02:49:20 +0100
From: Andrea Arcangeli <andrea@cpushare.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: Re: lcall disappeared? kernel CVS destabilized?
Message-ID: <20050114014920.GK5949@dualathlon.random>
References: <20050114010132.GJ5949@dualathlon.random> <20050113172651.70b4fcd5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050113172651.70b4fcd5.akpm@osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2005 at 05:26:51PM -0800, Andrew Morton wrote:
> Andrea Arcangeli <andrea@cpushare.com> wrote:
> >
> > I'm porting the seccomp patch to 2.6.10, do you have an idea where lcall
> >  (i.e. call gates for binary compatibility with other OS) went? 
> 
> Was removed on October 18.
> 
> http://linux.bkbits.net:8080/linux-2.5/diffs/arch/i386/kernel/entry.S@1.83?nav=index.html|src/|src/arch|src/arch/i386|src/arch/i386/kernel|hist/arch/i386/kernel/entry.S

Ok, thanks to both for the confirmation ;).
