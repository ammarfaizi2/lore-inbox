Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750994AbWDQUfV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbWDQUfV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 16:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbWDQUfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 16:35:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:6342 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750986AbWDQUfU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 16:35:20 -0400
Date: Mon, 17 Apr 2006 13:34:10 -0700
From: Greg KH <greg@kroah.com>
To: Chris Wright <chrisw@sous-sol.org>
Cc: Arjan van de Ven <arjan@infradead.org>, James Morris <jmorris@namei.org>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Stephen Smalley <sds@tycho.nsa.gov>, T?r?k Edwin <edwin@gurde.com>,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks)
Message-ID: <20060417203410.GA16886@kroah.com>
References: <1144863768.32059.67.camel@moss-spartans.epoch.ncsc.mil> <200604142301.10188.edwin@gurde.com> <1145290013.8542.141.camel@moss-spartans.epoch.ncsc.mil> <20060417162345.GA9609@infradead.org> <1145293404.8542.190.camel@moss-spartans.epoch.ncsc.mil> <20060417173319.GA11506@infradead.org> <Pine.LNX.4.64.0604171454070.17563@d.namei> <20060417202037.GB3615@sorel.sous-sol.org> <1145305493.2847.86.camel@laptopd505.fenrus.org> <20060417202751.GC3615@sorel.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060417202751.GC3615@sorel.sous-sol.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2006 at 01:27:51PM -0700, Chris Wright wrote:
> * Arjan van de Ven (arjan@infradead.org) wrote:
> > On Mon, 2006-04-17 at 13:20 -0700, Chris Wright wrote:
> > > * James Morris (jmorris@namei.org) wrote:
> > > > How about enough time to get us to 2.6.18, say, two months?
> > > 
> > > Based on the discussions we had last year, I think the fair date would
> > > be August not June.
> > 
> > why?
> > this is already a year notice...
> > lets get it over with.. notice goes in now
> > removal to -mm, goes into 2.6.18
> 
> Because the discussion we had at OLS last year (late July) was if there
> are no users in one year, it is gone.

Fair enough, I can't object to this.

And please, do not think that the little "rootplug" example is a real
user, it's an example only.

thanks,

greg k-h
