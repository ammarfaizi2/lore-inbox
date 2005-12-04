Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932228AbVLDXbr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbVLDXbr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 18:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbVLDXbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 18:31:46 -0500
Received: from mail.kroah.org ([69.55.234.183]:56784 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932228AbVLDXbq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 18:31:46 -0500
Date: Sun, 4 Dec 2005 15:29:03 -0800
From: Greg KH <greg@kroah.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Jeff Garzik <jgarzik@pobox.com>, Adrian Bunk <bunk@stusta.de>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Greg KH <gregkh@suse.de>,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: Golden rule: don't break userland (was Re: RFC: Starting a stable kernel series off the 2.6 kernel)
Message-ID: <20051204232903.GH8914@kroah.com>
References: <20051203135608.GJ31395@stusta.de> <4391E764.7050704@pobox.com> <20051203203418.GA4283@kroah.com> <200512032041.00594.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512032041.00594.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 03, 2005 at 08:40:59PM -0500, Dmitry Torokhov wrote:
> On Saturday 03 December 2005 15:34, Greg KH wrote:
> > And in the future, the driver/class model changes we are going to be
> > doing (see http://lwn.net/Articles/162242/ for more details on this),
> > will be going to great lengths to prevent anything in userspace from
> > breaking.
> 
> It is usually considered a bad netiquette to cross-post in public and
> subscription-only lists. I wonder if pointing to subscription-only
> service to get the feeling about planned driver core changes is a good
> idea.

My apologies.  It is merely a detailed description of what I wrote up
here:
	http://www.kroah.com/log/linux/driver_model_changes.html

I'll forward you a link to it off-list in a minute (and to anyone else
who wants it.)  After a week, lwn.net is free, so it will be public.

thanks,

greg k-h
