Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266510AbUFQO1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266510AbUFQO1M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 10:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266511AbUFQO1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 10:27:12 -0400
Received: from fmr99.intel.com ([192.55.52.32]:2249 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S266510AbUFQO1J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 10:27:09 -0400
Subject: Re: x86-64: double timer interrupts in recent 2.4.x
From: Len Brown <len.brown@intel.com>
To: Andi Kleen <ak@suse.de>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, peter@cordes.ca
In-Reply-To: <20040617122645.5d1b5ec1.ak@suse.de>
References: <200406170854.i5H8s0v5012548@alkaid.it.uu.se>
	 <20040617122645.5d1b5ec1.ak@suse.de>
Content-Type: text/plain
Organization: 
Message-Id: <1087482393.4487.56.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 17 Jun 2004 10:26:44 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-06-17 at 06:26, Andi Kleen wrote:
> On Thu, 17 Jun 2004 10:54:00 +0200 (MEST)
> Mikael Pettersson <mikpe@csd.uu.se> wrote:
> 
> > On Wed, 16 Jun 2004 16:28:26 -0300, Peter Cordes wrote:
> > > I just noticed that on my Opteron cluster, the nodes that are running 64bit
> > >kernels have their clocks ticking at double speed.  This happens with
> > >Linux 2.4.26, and 2.4.27-pre2
> > 
> > I had the same problem: 2.4 x86-64 kernels ticking the clock
> > twice its normal speed, unless I booted with pci=noacpi.
> > 
> > This got fixed very recently I believe, in a 2.4.27-pre kernel.
> 
> In which one exactly? Most likely it was an ACPI problem/fix.
> Len, do you remember fixing such an issue?

No, I don't remember this symptom.

-Len


