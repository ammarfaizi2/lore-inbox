Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264419AbUFCW7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264419AbUFCW7g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 18:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264518AbUFCW7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 18:59:35 -0400
Received: from fmr12.intel.com ([134.134.136.15]:47542 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S264419AbUFCW7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 18:59:32 -0400
From: Suresh Siddha <suresh.b.siddha@intel.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: [announce] [patch] NX (No eXecute) support for x86, 2.6.7-rc2-bk2
Date: Thu, 3 Jun 2004 15:58:27 -0700
User-Agent: KMail/1.6.2
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
References: <20040602205025.GA21555@elte.hu> <200406031224.13319.suresh.b.siddha@intel.com> <20040603203709.GB868@wotan.suse.de>
In-Reply-To: <20040603203709.GB868@wotan.suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406031558.27495.suresh.b.siddha@intel.com>
X-OriginalArrivalTime: 03 Jun 2004 22:58:24.0530 (UTC) FILETIME=[464D4720:01C449BE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 June 2004 13:37, Andi Kleen wrote:
> > What do you mean by "in the future"? on x86, with the current no execute 
> > patch, malloc() will be non-exec
> 
> On x86-64 the heap is executable right now at least.
> 

oh! I see. Looks like only Ingo's exec-shield patch is doing that.

thanks,
suresh
