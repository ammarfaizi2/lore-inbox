Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264468AbTLLDXL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 22:23:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264470AbTLLDXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 22:23:11 -0500
Received: from waste.org ([209.173.204.2]:30679 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S264468AbTLLDXH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 22:23:07 -0500
Date: Thu, 11 Dec 2003 21:23:01 -0600
From: Matt Mackall <mpm@selenic.com>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: gene.heskett@verizon.net, linux-kernel@vger.kernel.org,
       robustmutexes@lists.osdl.org
Subject: Re: [RFC/PATCH] FUSYN 5/10: kernel fuqueues
Message-ID: <20031212032301.GF23787@waste.org>
References: <A20D5638D741DD4DBAAB80A95012C0AE0125E23B@orsmsx409.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A20D5638D741DD4DBAAB80A95012C0AE0125E23B@orsmsx409.jf.intel.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 11, 2003 at 07:15:40PM -0800, Perez-Gonzalez, Inaky wrote:
> > From: Matt Mackall [mailto:mpm@selenic.com]
> 
> 
> > > > From: Gene Heskett [mailto:gene.heskett@verizon.net]
> > > >
> > > > inaky.perez-gonzalez@intel.com wrote:
> > > > >>  include/linux/fuqueue.h |  451
> > > > >> ++++++++++++++++++++++++++++++++++++++++++++++++
> > > > >> include/linux/plist.h   |  197 ++++++++++++++++++++
> > > > >>  kernel/fuqueue.c        |  220 +++++++++++++++++++++++
> > > > >>  3 files changed, 868 insertions(+)
> > > > >>
> > > > >> +++ linux/include/linux/fuqueue.h	Wed Nov 19 16:42:50 2003
> > > > >
> > > > >I don't suppose you've run this feature name past anyone in
> > > > > marketting or PR?
> > > >
> > > > Obviously not...
> > >
> > > I am already asking for new names for whoever doesn't like
> > > them, like me ... I have more interesting things to do than
> > > looking for names.
> > 
> > The name's fine by me actually, I'm greatly looking forward to hearing
> > someone present them at the next Linux Symposium.
> 
> I'll try to [at least I'll submit a proposal]...heh! :]
>  
> > Other people might not be so amused, though.
> 
> Do you mean on how similar it sounds to the famous four letter 
> word that everybody seems to be afraid to say in public? :) 
> 
> Well, I had initially (and intentionally) fucvar for a conditional 
> variable...however, in order to be more in order with how POSIX names
> them, I changed it to fucond. 
> 
> Good thing they were not worth to implement (and actually swearing 
> by them was a good thing, they were a real PITA).
> 
> Now seriously, forgive my naivete as English is my second language,
> what might be not so amusing to others? the 'fuck' thingie?

The obvious pronunciation is closer to "fuck you" (fuh-queue or
fuq-ueue), which is a little more pointed.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
