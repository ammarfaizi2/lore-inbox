Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261860AbVCOUNd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261860AbVCOUNd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 15:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbVCOUIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 15:08:41 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:36932 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261847AbVCOTze
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 14:55:34 -0500
Date: Tue, 15 Mar 2005 20:55:50 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Matt Mackall <mpm@selenic.com>
Cc: Greg KH <greg@kroah.com>, David Greaves <david@dgreaves.com>,
       "Randy.Dunlap" <rddunlap@osdl.org>, Greg Norris <haphazard@kc.rr.com>,
       linux-kernel@vger.kernel.org, akpm <akpm@osdl.org>
Subject: Re: [BUG] Re: [PATCH] scripts/patch-kernel: use EXTRAVERSION
Message-ID: <20050315195550.GA8582@mars.ravnborg.org>
References: <20040814115548.A19527@infradead.org> <Pine.LNX.4.58.0408140404050.1839@ppc970.osdl.org> <411E0A37.5040507@anomalistic.org> <20040814205707.GA11936@yggdrasil.localdomain> <20040818135751.197ce3c9.rddunlap@osdl.org> <20040822204002.GB8639@mars.ravnborg.org> <42370A3A.6020206@dgreaves.com> <20050315162545.GB24796@kroah.com> <20050315174424.GB26060@kroah.com> <20050315175436.GP32638@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050315175436.GP32638@waste.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 
> > Actually, why not just replace patch-kernel with ketchup?
> > 
> > Matt, is that ok with you?
> 
> Yes. There are a handful of cleanups that I should do first though.

Please make one of those a better help.
It should be obvious that ketchup 2.6-mm fetch newest -mm

At least in my current installation there is no help on <ver>

If stored in the kernel we should name if after it's usage rather than a
nickname - OK?

	Sam
