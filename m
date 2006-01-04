Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751261AbWADXLP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbWADXLP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 18:11:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751819AbWADXLO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 18:11:14 -0500
Received: from mail.kroah.org ([69.55.234.183]:64407 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751818AbWADXLN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 18:11:13 -0500
Date: Wed, 4 Jan 2006 15:10:34 -0800
From: Greg KH <greg@kroah.com>
To: Nick Warne <nick@linicks.net>
Cc: Jesper Juhl <jesper.juhl@gmail.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org,
       webmaster@kernel.org
Subject: Re: 2.6.14.5 to 2.6.15 patch
Message-ID: <20060104231034.GB14788@kroah.com>
References: <200601041710.37648.nick@linicks.net> <200601042220.59637.nick@linicks.net> <9a8748490601041430g67720b14h10474d9be5059d9@mail.gmail.com> <200601042236.10293.nick@linicks.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601042236.10293.nick@linicks.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2006 at 10:36:10PM +0000, Nick Warne wrote:
> On Wednesday 04 January 2006 22:30, Jesper Juhl wrote:
> 
> > > (according to kernel.org).  Yet there is no upgrade path for that build
> > > (or any other .x releases)
> > >
> > > It is a bit of a mess really.
> >
> > but, a 2.6.14.6 kernel might come out *after* 2.6.15, then what?
> 
> Nightmares...

It's already happened, we did a 2.6.13.y release after 2.6.14 was out,
and I'm about to do a 2.6.14.y release in a few days too :)

> I get all the points.  Let me say then it needs better distinction on
> what the 'latest kernel' is and on what the 'latest -stable' is.

Ok, exactly how would you like this to be shown?

Again, 2.6.15 is the latest stable kernel right now.  Just because there
isn't a .1 release yet, doesn't mean it isn't.

thanks,

greg k-h
