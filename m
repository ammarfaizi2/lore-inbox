Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264464AbTLLC5U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 21:57:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264466AbTLLC5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 21:57:20 -0500
Received: from waste.org ([209.173.204.2]:20950 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S264464AbTLLC5S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 21:57:18 -0500
Date: Thu, 11 Dec 2003 20:57:07 -0600
From: Matt Mackall <mpm@selenic.com>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: gene.heskett@verizon.net, linux-kernel@vger.kernel.org,
       robustmutexes@lists.osdl.org
Subject: Re: [RFC/PATCH] FUSYN 5/10: kernel fuqueues
Message-ID: <20031212025707.GE23787@waste.org>
References: <A20D5638D741DD4DBAAB80A95012C0AE0125E21E@orsmsx409.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A20D5638D741DD4DBAAB80A95012C0AE0125E21E@orsmsx409.jf.intel.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 11, 2003 at 04:06:18PM -0800, Perez-Gonzalez, Inaky wrote:
> 
> > From: Gene Heskett [mailto:gene.heskett@verizon.net]
> > 
> > inaky.perez-gonzalez@intel.com wrote:
> > >>  include/linux/fuqueue.h |  451
> > >> ++++++++++++++++++++++++++++++++++++++++++++++++
> > >> include/linux/plist.h   |  197 ++++++++++++++++++++
> > >>  kernel/fuqueue.c        |  220 +++++++++++++++++++++++
> > >>  3 files changed, 868 insertions(+)
> > >>
> > >> +++ linux/include/linux/fuqueue.h	Wed Nov 19 16:42:50 2003
> > >
> > >I don't suppose you've run this feature name past anyone in
> > > marketting or PR?
> > 
> > Obviously not...
> 
> So?
> 
> I am already asking for new names for whoever doesn't like
> them, like me ... I have more interesting things to do than
> looking for names.

The name's fine by me actually, I'm greatly looking forward to hearing
someone present them at the next Linux Symposium.

Other people might not be so amused, though.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
