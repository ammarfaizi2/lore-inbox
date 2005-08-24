Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbVHXLrD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbVHXLrD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 07:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbVHXLrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 07:47:03 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:12181 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1750799AbVHXLrB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 07:47:01 -0400
Date: Wed, 24 Aug 2005 04:46:48 -0700
From: Paul Jackson <pj@sgi.com>
To: dino@in.ibm.com
Cc: paulus@samba.org, akpm@osdl.org, nickpiggin@yahoo.com.au,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, mingo@elte.hu, hawkes@sgi.com
Subject: Re: [PATCH 2.6.13-rc6] cpu_exclusive sched domains build fix
Message-Id: <20050824044648.66f7e25a.pj@sgi.com>
In-Reply-To: <20050824112640.GB5197@in.ibm.com>
References: <20050824111510.11478.49764.sendpatchset@jackhammer.engr.sgi.com>
	<20050824112640.GB5197@in.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dinakar wrote:
> Can we hold on to this patch for a while, as I reported yesterday,

Sure - though I guess it's Linus or Andrew who will have to do
the holding.

I sent it off contingent on the approval of yourself, Hawkes and Nick.

It looks like Linus is living dangerously and put it in already without
your approval. Hawkes reports of the oops if we didn't do something was
definitely motivating us to try something.

Good luck with your fix.  Let us know when you understand it.

I'm not quite sure how close Linus is to releasing 2.6.13, or
what would best serve his needs here.  The best I can do is push
on, be transparent, and let Linus holler if he has a better idea.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
