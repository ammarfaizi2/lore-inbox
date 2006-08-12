Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964794AbWHLAno@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964794AbWHLAno (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 20:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964804AbWHLAno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 20:43:44 -0400
Received: from hera.kernel.org ([140.211.167.34]:40367 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S964794AbWHLAnn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 20:43:43 -0400
Date: Fri, 11 Aug 2006 21:14:57 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: Willy Tarreau <w@1wt.eu>
Cc: Benjamin Cherian <benjamin.cherian.kernel@gmail.com>,
       Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, marcelo@kvack.org
Subject: Re: Bug with USB proc_bulk in 2.4 kernel
Message-ID: <20060812001457.GA2676@dmt>
References: <mailman.1152332281.24203.linux-kernel2news@redhat.com> <200608040957.05034.benjamin.cherian.kernel@gmail.com> <20060804165550.GA26701@1wt.eu> <200608091001.43570.benjamin.cherian.kernel@gmail.com> <20060809170201.GA25530@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060809170201.GA25530@1wt.eu>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2006 at 07:02:01PM +0200, Willy Tarreau wrote:
> Hi Benjamin,
> 
> On Wed, Aug 09, 2006 at 10:01:41AM -0700, Benjamin Cherian wrote:
> > Willy,
> > Sorry I didn't notice your email till now.
> 
> no problem.
> 
> > On Friday 04 August 2006 09:55, Willy Tarreau wrote:
> > > The problem is that Marcelo is very very busy those days (as you might have
> > > noticed from the delay between each release), and there are a good bunch of
> > > security fixes in -rc3 which should wait too much in -rc. Maybe an -rc4
> > > would be OK, but I don't know if Marcelo has enough time to spend on yet
> > > another RC. Otherwise, if I produce a 2.4.34-pre1 about one week after
> > > 2.4.33, does that fit your needs ? I already have a few fixes waiting which
> > > might be worth a first pre-release.
> > 
> > It would be nice if you could do another rc, because otherwise it seems the 
> > patch wouldn't get into a stable kernel for a long time. But if it's really 
> > too much work for Marcelo, I would understand you putting it in th 2.4.34 
> > pre-release.
> 
> The real problem is that Marcelo seems to be *very* busy. I failed to get
> any contact from him from one week now. It's even becoming worrying, I hope
> he's alright. I don't know how much time it would take him to produce another
> release, but it will for sure delay 2.4.33 for a few weeks during which Marcelo
> will still be bound to this time-consuming task. It's left to him to decide
> anyway. In normal ciscumstances, I would for sure add another -rc, but delays
> get stretched too far given the number of vulnerabilities fixed in 2.4.33.

The reason for so much delay was a serious accident which resulted in 2
weeks of hospitalization with no Internet connnectivity (and no mental
state for work).

Sorry about that.

