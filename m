Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261874AbTANJRU>; Tue, 14 Jan 2003 04:17:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261894AbTANJRU>; Tue, 14 Jan 2003 04:17:20 -0500
Received: from dp.samba.org ([66.70.73.150]:58788 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261874AbTANJRT>;
	Tue, 14 Jan 2003 04:17:19 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15907.55035.787654.77224@argo.ozlabs.ibm.com>
Date: Tue, 14 Jan 2003 20:23:07 +1100
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, Corey Minyard <minyard@mvista.com>
Subject: Re: IPMI
In-Reply-To: <20030114084011.6AB412C466@lists.samba.org>
References: <20030114084011.6AB412C466@lists.samba.org>
X-Mailer: VM 7.07 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell writes:

> Telling me what IPMI is, and why I might need it, would be a good
> thing...  Please, Corey, I'm feeling generation-gapped by the
> acronyms...

There is a Documentation/IPMI.txt, which would serve as an excellent
example of how _not_ to write a documentation file, should you ever
decide to write a "Rusty's Unreliable Guide to Writing Kernel
Documentation" and need an example to pillory.  I quote:


> 			    The Linux IPMI Driver
> 			    ---------------------
> 				Corey Minyard
> 			    <minyard@mvista.com>
> 			      <minyard@acm.org>
> 
> This document describes how to use the IPMI driver for Linux.  If you
> are not familiar with IPMI itself, see the web site at
> http://www.intel.com/design/servers/ipmi/index.htm.  IPMI is a big
> subject and I can't cover it all here!

Maybe it can't all be covered here, but some basic explanation of what
IPMI is and does is essential, even if just so that people who don't
need IPMI can work that out.

Paul.
