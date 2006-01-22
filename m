Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932330AbWAVW5g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbWAVW5g (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 17:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbWAVW5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 17:57:36 -0500
Received: from iabervon.org ([66.92.72.58]:62476 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932330AbWAVW5f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 17:57:35 -0500
Date: Sun, 22 Jan 2006 17:59:36 -0500 (EST)
From: Daniel Barkalow <barkalow@iabervon.org>
To: Michael Loftis <mloftis@wgops.com>
cc: Bernd Petrovitsch <bernd@firmix.at>, Lee Revell <rlrevell@joe-job.com>,
       Sven-Haegar Koch <haegar@sdinet.de>,
       Matthew Frost <artusemrys@sbcglobal.net>, linux-kernel@vger.kernel.org,
       James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: Development tree, PLEASE?
In-Reply-To: <4BC1BE8FDDB41AAA7205E258@dhcp-2-206.wgops.com>
Message-ID: <Pine.LNX.4.64.0601221723360.25300@iabervon.org>
References: <20060121031958.98570.qmail@web81905.mail.mud.yahoo.com> 
 <1FA093EB58B02DE48E424157@dhcp-2-206.wgops.com>  <1137829140.3241.141.camel@mindpipe>
  <Pine.LNX.4.64.0601212250020.31384@mercury.sdinet.de>  <1137881882.411.23.camel@mindpipe>
  <3B0BEE012630B9B11D1209E5@dhcp-2-206.wgops.com>  <1137883638.411.38.camel@mindpipe>
 <1137883888.3291.53.camel@gimli.at.home> <4BC1BE8FDDB41AAA7205E258@dhcp-2-206.wgops.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Jan 2006, Michael Loftis wrote:

> Yes, I realise all of this.  But everyone seems to get this damned 
> territorial attitude that I want to see kernel development stopped, 
> quite the opposite.  All I want to see is a stable target for certain 
> windows of time.  So that way when bugs are fixed that are trivial 
> there's a place to go without upgrading scads of userland stuff or 
> worrying about lots of unrelated change.

I believe that, if you want to maintain a 2.6.13.y (for example) tree 
after the -stable team has moved on, you'd be perfectly welcome, and could 
probably even do it on kernel.org. It might not even be that hard to get 
the necessary patches, given that -stable sees all of the long-standing 
stability/security bugs (so you can watch that list for ones you should 
include patches for), and the regressions will probably mostly be fixed 
before you get the series.

I think that the reason that nobody's done this already isn't that it 
would be very difficult, but that distributions don't actually see a value 
in using old kernel series and are happy with -stable. If you have a 
reason to stick with a series longer, it might be worth the trouble to 
you.

	-Daniel
*This .sig left intentionally blank*
