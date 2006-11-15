Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030478AbWKOOLN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030478AbWKOOLN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 09:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030482AbWKOOLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 09:11:13 -0500
Received: from kallisti.us ([67.59.168.233]:61957 "EHLO kallisti.us")
	by vger.kernel.org with ESMTP id S1030478AbWKOOLL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 09:11:11 -0500
From: Ross Vandegrift <ross@kallisti.us>
Date: Wed, 15 Nov 2006 09:10:48 -0500
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: Marc Perkel <mperkel@yahoo.com>, Al Viro <viro@ftp.linux.org.uk>,
       David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org
Subject: Re: Majordomo is an obsolete piece of junk and Kernel should not be running it!
Message-ID: <20061115141047.GA22345@kallisti.us>
References: <20061114.200507.21927677.davem@davemloft.net> <20061115042335.11460.qmail@web52506.mail.yahoo.com> <20061115054124.GA29920@ftp.linux.org.uk> <20061115111049.GK10054@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061115111049.GK10054@mea-ext.zmailer.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2006 at 01:10:49PM +0200, Matti Aarnio wrote:
> > On Tue, Nov 14, 2006 at 08:23:35PM -0800, Marc Perkel wrote:
> >  
> > > This is the only list I get booted from so that makes
> > > me think the problem is with the list and not with me.
> > > It seems that you are also using 12 year old software
> > > as well.  Why not get something modern like Mailman
> > > like most other lists use and then you don't have to
> > > be watching the bounces? 
> 
> More like 20 years old..
> 
> With mailman handling the bounces..  Leaked in spams will
> cause subscribers to be dropped right and left, and far
> sooner than after 5 days of persistent non-delivery...

The Mailman suggestion was obviously made by someone that's never
managed a list of any substantial size.  Mailman might have lots of
fancy bounce processing stuff, but man, it loves to burn CPU all day
and night working it.

I was once burdened with limping a huge mailman installation along
while the list was moved to a service that was a bit more up to
handling the task.  The list was an announce only list for some
celebrity with about 500,000 subscribers.  Mailman's bounce processing
happily burned all the CPU that might've gone to actually doing mail
delivery.  Messages took weeks to deliver.

While I'm sure that lkml doesn't attract as much crap recipients as a
famous person's announcement, I'm sure it has plenty.  I was so happy
when that list went away...

-- 
Ross Vandegrift
ross@kallisti.us

"The good Christian should beware of mathematicians, and all those who
make empty prophecies. The danger already exists that the mathematicians
have made a covenant with the devil to darken the spirit and to confine
man in the bonds of Hell."
	--St. Augustine, De Genesi ad Litteram, Book II, xviii, 37
