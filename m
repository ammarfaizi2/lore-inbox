Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264261AbUFCUhT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264261AbUFCUhT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 16:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264108AbUFCUhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 16:37:19 -0400
Received: from cantor.suse.de ([195.135.220.2]:34992 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264275AbUFCUhL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 16:37:11 -0400
Date: Thu, 3 Jun 2004 22:37:09 +0200
From: Andi Kleen <ak@suse.de>
To: Suresh Siddha <suresh.b.siddha@intel.com>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, Arjan van de Ven <arjanv@redhat.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [announce] [patch] NX (No eXecute) support for x86, 2.6.7-rc2-bk2
Message-ID: <20040603203709.GB868@wotan.suse.de>
References: <20040602205025.GA21555@elte.hu> <20040603072146.GA14441@elte.hu> <20040603124448.GA28775@elte.hu> <200406031224.13319.suresh.b.siddha@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406031224.13319.suresh.b.siddha@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What do you mean by "in the future"? on x86, with the current no execute 
> patch, malloc() will be non-exec

On x86-64 the heap is executable right now at least.

-Andi
