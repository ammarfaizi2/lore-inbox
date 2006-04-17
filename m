Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751254AbWDQUoH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbWDQUoH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 16:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbWDQUoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 16:44:07 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:23762 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751210AbWDQUoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 16:44:04 -0400
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7]
	implementation of LSM hooks)
From: Arjan van de Ven <arjan@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: Chris Wright <chrisw@sous-sol.org>, James Morris <jmorris@namei.org>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Stephen Smalley <sds@tycho.nsa.gov>, T?r?k Edwin <edwin@gurde.com>,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20060417203410.GA16886@kroah.com>
References: <1144863768.32059.67.camel@moss-spartans.epoch.ncsc.mil>
	 <200604142301.10188.edwin@gurde.com>
	 <1145290013.8542.141.camel@moss-spartans.epoch.ncsc.mil>
	 <20060417162345.GA9609@infradead.org>
	 <1145293404.8542.190.camel@moss-spartans.epoch.ncsc.mil>
	 <20060417173319.GA11506@infradead.org>
	 <Pine.LNX.4.64.0604171454070.17563@d.namei>
	 <20060417202037.GB3615@sorel.sous-sol.org>
	 <1145305493.2847.86.camel@laptopd505.fenrus.org>
	 <20060417202751.GC3615@sorel.sous-sol.org>
	 <20060417203410.GA16886@kroah.com>
Content-Type: text/plain
Date: Mon, 17 Apr 2006 22:43:55 +0200
Message-Id: <1145306636.2847.88.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-17 at 13:34 -0700, Greg KH wrote:
> On Mon, Apr 17, 2006 at 01:27:51PM -0700, Chris Wright wrote:
> > * Arjan van de Ven (arjan@infradead.org) wrote:
> > > On Mon, 2006-04-17 at 13:20 -0700, Chris Wright wrote:
> > > > * James Morris (jmorris@namei.org) wrote:
> > > > > How about enough time to get us to 2.6.18, say, two months?
> > > > 
> > > > Based on the discussions we had last year, I think the fair date would
> > > > be August not June.
> > > 
> > > why?
> > > this is already a year notice...
> > > lets get it over with.. notice goes in now
> > > removal to -mm, goes into 2.6.18
> > 
> > Because the discussion we had at OLS last year (late July) was if there
> > are no users in one year, it is gone.
> 
> Fair enough, I can't object to this.

I still think at least in -mm the patch to remove it should go in early,
just to make sure it'll be a smooth transition.


