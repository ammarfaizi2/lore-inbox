Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261558AbVALXNE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261558AbVALXNE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 18:13:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261229AbVALXLx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 18:11:53 -0500
Received: from fw.osdl.org ([65.172.181.6]:38307 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261555AbVALXKj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 18:10:39 -0500
Date: Wed, 12 Jan 2005 15:10:38 -0800
From: Chris Wright <chrisw@osdl.org>
To: Florian Weimer <fw@deneb.enyo.de>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: thoughts on kernel security issues
Message-ID: <20050112151038.W469@build.pdx.osdl.net>
References: <20050112094807.K24171@build.pdx.osdl.net> <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org> <20050112185133.GA10687@kroah.com> <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org> <20050112191814.GA11042@kroah.com> <87sm56e8po.fsf@deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <87sm56e8po.fsf@deneb.enyo.de>; from fw@deneb.enyo.de on Wed, Jan 12, 2005 at 08:41:23PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Florian Weimer (fw@deneb.enyo.de) wrote:
> * Greg KH:
> 
> >> In other words, if you allow embargoes and vendor politics, what would the 
> >> new list buy that isn't already in vendor-sec.
> >
> > vendor-sec handles a lot of other stuff that is not kernel related
> > (every package that is in a distro.) This would only be for the kernel.
> 
> I don't know that much about vendor-sec, but wouldn't the kernel list
> contain roughly the same set of people?

No.

> vendor-sec also has people
> from the *BSDs, I believe, but they should probably notified of Linux
> issues as well (often, similar mistakes are made in different
> implementations).

Take a look at <http://www.freebsd.org/security/index.html>.  Pretty
good description.  It's normal for projects to have their own security
contact to handle security issues.  Once it's vetted, understood,
etc...it's normal to give vendors some heads-up.

> If the readership is the same, it doesn't make sense to run two lists,
> especially because it's not a normal list and you have to be capable
> to deal with the vetting.

It's not the same readership.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
