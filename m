Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261260AbVALS4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbVALS4a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 13:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbVALSyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 13:54:38 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:22659 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261260AbVALSvj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 13:51:39 -0500
Date: Wed, 12 Jan 2005 10:51:33 -0800
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Chris Wright <chrisw@osdl.org>, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: Re: thoughts on kernel security issues
Message-ID: <20050112185133.GA10687@kroah.com>
References: <20050112094807.K24171@build.pdx.osdl.net> <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2005 at 10:05:34AM -0800, Linus Torvalds wrote:
> 
> 
> On Wed, 12 Jan 2005, Chris Wright wrote:
> >
> > This same discussion is taking place in a few forums.  Are you opposed to
> > creating a security contact point for the kernel for people to contact
> > with potential security issues?  This is standard operating procedure
> > for many projects and complies with RFPolicy.
> 
> I wouldn't mind, and it sounds like a good thing to have. The _only_
> requirement that I have is that there be no stupid embargo on the list.
> Any list with a time limit (vendor-sec) I will not have anything to do
> with.
> 
> If that means that you can get only the list by invitation-only, that's
> fine. 

So you would be for a closed list, but there would be no incentive at
all for anyone on the list to keep the contents of what was posted to
the list closed at any time?  That goes against the above stated goal of
complying with RFPolicy.

I understand your dislike of having to wait once you know of a security
issue before making the fix public, but how should distros coordinate
fixes in any other way?

thanks,

greg k-h
