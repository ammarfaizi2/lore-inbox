Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261238AbVALTol@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbVALTol (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 14:44:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261335AbVALTlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 14:41:51 -0500
Received: from fw.osdl.org ([65.172.181.6]:2271 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261336AbVALTiW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 14:38:22 -0500
Date: Wed, 12 Jan 2005 11:38:20 -0800
From: Chris Wright <chrisw@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Chris Wright <chrisw@osdl.org>,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org
Subject: Re: thoughts on kernel security issues
Message-ID: <20050112113820.R24171@build.pdx.osdl.net>
References: <20050112094807.K24171@build.pdx.osdl.net> <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org> <20050112185133.GA10687@kroah.com> <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org> <20050112191814.GA11042@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050112191814.GA11042@kroah.com>; from greg@kroah.com on Wed, Jan 12, 2005 at 11:18:14AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Greg KH (greg@kroah.com) wrote:
> On Wed, Jan 12, 2005 at 11:01:42AM -0800, Linus Torvalds wrote:
> > On Wed, 12 Jan 2005, Greg KH wrote:
> > > So you would be for a closed list, but there would be no incentive at
> > > all for anyone on the list to keep the contents of what was posted to
> > > the list closed at any time?  That goes against the above stated goal of
> > > complying with RFPolicy.
> > 
> > There's already vendor-sec. I assume they follow RFPolicy already. If it's 
> > just another vendor-sec, why would you put up a new list for it?
> 
> I think the issue is that there is no main "security" contact for the
> kernel.  If we want to make vendor-sec that contact, fine, but we better
> warn the vendor-sec people :)

Yes.  And I think we should have our own contact.

> > In other words, if you allow embargoes and vendor politics, what would the 
> > new list buy that isn't already in vendor-sec.
> 
> vendor-sec handles a lot of other stuff that is not kernel related
> (every package that is in a distro.) This would only be for the kernel.

Yes, and IMO, it could inform vendor-sec.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
