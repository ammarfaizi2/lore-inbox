Return-Path: <linux-kernel-owner+w=401wt.eu-S1425784AbWLHRKh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425784AbWLHRKh (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 12:10:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1426018AbWLHRKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 12:10:37 -0500
Received: from mail.suse.de ([195.135.220.2]:37441 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1425784AbWLHRKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 12:10:35 -0500
From: Andi Kleen <ak@suse.de>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: Re: What was in the x86 merge for .20
Date: Fri, 8 Dec 2006 18:10:29 +0100
User-Agent: KMail/1.9.5
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, "Li, Shaohua" <shaohua.li@intel.com>,
       Ingo Molnar <mingo@elte.hu>
References: <200612080401.25746.ak@suse.de> <20061208020804.c5e5e176.akpm@osdl.org> <20061208084124.C31153@unix-os.sc.intel.com>
In-Reply-To: <20061208084124.C31153@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612081810.29792.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 December 2006 17:41, Siddha, Suresh B wrote:
> On Fri, Dec 08, 2006 at 02:08:04AM -0800, Andrew Morton wrote:
> > On Fri, 8 Dec 2006 04:01:25 +0100
> > Andi Kleen <ak@suse.de> wrote:
> > 
> > > [The merge already made it to Linus' tree. Sorry for sending this message
> > > late]
> > > 
> > > Most of this is for both i386 and x86-64, unless when noted
> > > 
> > > These are just some high lights. As usual there are more
> > > smaller optimizations, cleanups etc
> > 
> > My old 4-way Intel Nocona-based SDV panics during boot with "APIC mode must
> > be flat on this system" and I don't know how to make it stop.  Help.
> 
> I am glad that the patch atleast found a mismerge ;)
> 
> I see Andrew posted bunch of patches to Andi to correct this. Please let me
> know which tree (git?) I should take a look at and see if all
> the pieces are in order.

Yes please check the mainline git tree.

-Andi
