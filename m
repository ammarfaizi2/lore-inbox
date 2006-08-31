Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbWHaOns@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbWHaOns (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 10:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932168AbWHaOns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 10:43:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:14768 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932164AbWHaOnr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 10:43:47 -0400
From: Andi Kleen <ak@suse.de>
To: Tom Rini <trini@kernel.crashing.org>
Subject: Re: [Kgdb-bugreport] [RFC] [Crash-utility] Patch to use gdb's bt in crash - =?iso-8859-1?q?works=09great_with_kgdb!_-_KGDB_in_Linus?= Kernel.
Date: Thu, 31 Aug 2006 16:43:37 +0200
User-Agent: KMail/1.9.3
Cc: piet@bluelane.com, Andrew Morton <akpm@osdl.org>,
       kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       George Anzinger <george@wildturkeyranch.net>, vgoyal@in.ibm.com,
       Subhachandra Chandra <schandra@bluelane.com>
References: <44EC8CA5.789286A@redhat.com> <p73lkp5578s.fsf@verdi.suse.de> <20060831142036.GF23227@smtp.west.cox.net>
In-Reply-To: <20060831142036.GF23227@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608311643.38012.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 31 August 2006 16:20, Tom Rini wrote:
> On Thu, Aug 31, 2006 at 04:07:15PM +0200, Andi Kleen wrote:
> > Piet Delaney <piet@bluelane.com> writes:
> > > > 
> > > > ENOPATCH
> > > 
> > > Opps. 
> > 
> > What an ugly patch!
> > 
> > But it should be totally obsolete with the unwinder work Jan and me have been
> > doing recently which does this all properly. .18 isn't quite there
> > yet in all cases, but .19 will be hopefully.
> 
> Indeed.  But quite functional.  Have you guys been doing i386 as well?

Yes.

-Andi

P.S.: Please don't include member only lists in linux-kernel cc lists. Dropped.
