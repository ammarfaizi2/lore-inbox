Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261299AbVALTok@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbVALTok (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 14:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbVALTmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 14:42:23 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34994 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261349AbVALThJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 14:37:09 -0500
Date: Wed, 12 Jan 2005 14:12:27 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Greg KH <greg@kroah.com>, Chris Wright <chrisw@osdl.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: thoughts on kernel security issues
Message-ID: <20050112161227.GF32024@logos.cnet>
References: <20050112094807.K24171@build.pdx.osdl.net> <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org> <20050112185133.GA10687@kroah.com> <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2005 at 11:01:42AM -0800, Linus Torvalds wrote:
> 
> 
> On Wed, 12 Jan 2005, Greg KH wrote:
> > 
> > So you would be for a closed list, but there would be no incentive at
> > all for anyone on the list to keep the contents of what was posted to
> > the list closed at any time?  That goes against the above stated goal of
> > complying with RFPolicy.
> 
> There's already vendor-sec. I assume they follow RFPolicy already. If it's 
> just another vendor-sec, why would you put up a new list for it?
> 
> In other words, if you allow embargoes and vendor politics, what would the 
> new list buy that isn't already in vendor-sec.
> 
> When I saw how vendor-sec worked, I decided I will never be on an embargo 
> list. Ever. That's not to say that such a list can't work - I just 
> personally refuse to have anything to do with one. Whether that matters or
> not is obviously an open question.

Of course it matters Linus - vendors need time to prepare their updates. You 
can't ignore that, and you can't "have nothing to do with it". 

You seem to dislike the way embargos have been done on vendorsec, fine. They can
be done on a different way, but you have to understand that you and Andrew
need to follow and agree with the embargo.

How you feel about having short fixed time embargo's (lets say, 3 or 4 days) ? 

The only reason for this is to have "time for the vendors to catch up", which 
can be defined by the kernel security office. Nothing more - no vendor politics
involved.

It is a simple matter of synchronization.

