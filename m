Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261830AbVAYGJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261830AbVAYGJg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 01:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261832AbVAYGJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 01:09:25 -0500
Received: from mail.kroah.org ([69.55.234.183]:38881 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261830AbVAYGJI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 01:09:08 -0500
Date: Mon, 24 Jan 2005 22:02:56 -0800
From: Greg KH <greg@kroah.com>
To: Christoph Hellwig <hch@infradead.org>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc2-mm1: SuperIO scx200 breakage
Message-ID: <20050125060256.GB2061@kroah.com>
References: <20050124021516.5d1ee686.akpm@osdl.org> <20050124175449.GK3515@stusta.de> <20050124213442.GC18933@kroah.com> <20050124214751.GA6396@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050124214751.GA6396@infradead.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2005 at 09:47:51PM +0000, Christoph Hellwig wrote:
> On Mon, Jan 24, 2005 at 01:34:42PM -0800, Greg KH wrote:
> > And as for the "these patches have never been reviewed" comments, that's
> > why I put them in my tree, and have them show up in -mm.  It's getting
> > them a wider exposure and finding out these kinds of issues.  So the
> > process is working properly :)
> 
> It would be a lot more productive to follow the normal rules, though.
> That is posting them on lkml as properly split up patches, and with
> proper descriptions of what they're doing.

As previously mentioned, these patches have had that, on the sensors
mailing list.  Lots of review and comments went into them there, and the
code was reworked quite a lot based on it.

Surely you don't want me to forward _every_ driver patch that I get to
lkml first?  :)

That's what all of the subsystem specific mailing lists are for...

thanks,

greg k-h

