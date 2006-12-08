Return-Path: <linux-kernel-owner+w=401wt.eu-S1425938AbWLHRHo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425938AbWLHRHo (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 12:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425702AbWLHRHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 12:07:43 -0500
Received: from mga07.intel.com ([143.182.124.22]:34989 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1425932AbWLHRHk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 12:07:40 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,515,1157353200"; 
   d="scan'208"; a="155681328:sNHT35063945"
Date: Fri, 8 Dec 2006 08:41:24 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, discuss@x86-64.org,
       Suresh Siddha <suresh.b.siddha@intel.com>,
       "Li, Shaohua" <shaohua.li@intel.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: What was in the x86 merge for .20
Message-ID: <20061208084124.C31153@unix-os.sc.intel.com>
References: <200612080401.25746.ak@suse.de> <20061208020804.c5e5e176.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20061208020804.c5e5e176.akpm@osdl.org>; from akpm@osdl.org on Fri, Dec 08, 2006 at 02:08:04AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2006 at 02:08:04AM -0800, Andrew Morton wrote:
> On Fri, 8 Dec 2006 04:01:25 +0100
> Andi Kleen <ak@suse.de> wrote:
> 
> > [The merge already made it to Linus' tree. Sorry for sending this message
> > late]
> > 
> > Most of this is for both i386 and x86-64, unless when noted
> > 
> > These are just some high lights. As usual there are more
> > smaller optimizations, cleanups etc
> 
> My old 4-way Intel Nocona-based SDV panics during boot with "APIC mode must
> be flat on this system" and I don't know how to make it stop.  Help.

I am glad that the patch atleast found a mismerge ;)

I see Andrew posted bunch of patches to Andi to correct this. Please let me
know which tree (git?) I should take a look at and see if all
the pieces are in order.

thanks,
suresh
