Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267330AbUG2JaA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267330AbUG2JaA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 05:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267379AbUG2J37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 05:29:59 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:21680 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S267330AbUG2J3k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 05:29:40 -0400
Date: Thu, 29 Jul 2004 11:29:34 +0200
From: Jens Axboe <axboe@suse.de>
To: tabris <tabris@tabris.net>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [Repost] IDE error 2.6.7-rc3-mm2 and 2.6.8-rc1-mm1
Message-ID: <20040729092934.GU10377@suse.de>
References: <200407220659.22948.tabris@tabriel.tabris.net> <200407271407.10631.tabris@tabris.net> <20040727195224.GA10654@suse.de> <200407290526.08113.tabris@tabris.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407290526.08113.tabris@tabris.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29 2004, tabris wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On Tuesday 27 July 2004 3:52 pm, Jens Axboe wrote:
> > On Tue, Jul 27 2004, tabris wrote:
> > > On Thursday 22 July 2004 11:39 am, Jens Axboe wrote:
> > > > On Thu, Jul 22 2004, Tabris wrote:
> > > > > -----BEGIN PGP SIGNED MESSAGE-----
> > > > > Hash: SHA1
> > >
> >
> > Try this.
> 	Works. I don't see the error in my syslog anymore. Thank you.
> 	Hopefully this fix will make it into -mm and/or mainline soon.

It's already in the released 2.6.8-rc2-mm1 from yesterday. Thanks for
testing and verifying it works, I'm sure Andrew appreciates that as well
:-)

-- 
Jens Axboe

