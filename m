Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750993AbWDQU3P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993AbWDQU3P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 16:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbWDQU3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 16:29:15 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:10113 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1750993AbWDQU3O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 16:29:14 -0400
Date: Mon, 17 Apr 2006 13:27:51 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Chris Wright <chrisw@sous-sol.org>, James Morris <jmorris@namei.org>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Stephen Smalley <sds@tycho.nsa.gov>, T?r?k Edwin <edwin@gurde.com>,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks)
Message-ID: <20060417202751.GC3615@sorel.sous-sol.org>
References: <200604072138.35201.edwin@gurde.com> <1144863768.32059.67.camel@moss-spartans.epoch.ncsc.mil> <200604142301.10188.edwin@gurde.com> <1145290013.8542.141.camel@moss-spartans.epoch.ncsc.mil> <20060417162345.GA9609@infradead.org> <1145293404.8542.190.camel@moss-spartans.epoch.ncsc.mil> <20060417173319.GA11506@infradead.org> <Pine.LNX.4.64.0604171454070.17563@d.namei> <20060417202037.GB3615@sorel.sous-sol.org> <1145305493.2847.86.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145305493.2847.86.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Arjan van de Ven (arjan@infradead.org) wrote:
> On Mon, 2006-04-17 at 13:20 -0700, Chris Wright wrote:
> > * James Morris (jmorris@namei.org) wrote:
> > > How about enough time to get us to 2.6.18, say, two months?
> > 
> > Based on the discussions we had last year, I think the fair date would
> > be August not June.
> 
> why?
> this is already a year notice...
> lets get it over with.. notice goes in now
> removal to -mm, goes into 2.6.18

Because the discussion we had at OLS last year (late July) was if there
are no users in one year, it is gone.

> as it is its one helluva hook for the rootkit guys with only pain on the
> kernel side (eg selinux) because of the super abstraction.

The rootkit argument is not that compelling.  Lack of users certainly is.

thanks,
-chris
