Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933179AbWKNHKV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933179AbWKNHKV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 02:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933199AbWKNHKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 02:10:21 -0500
Received: from mail.gmx.de ([213.165.64.20]:54401 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S933179AbWKNHKU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 02:10:20 -0500
X-Authenticated: #14349625
Subject: Re: [ltp] Re: paging request BUG in 2.6.19-rc5 on resume - X60s
From: Mike Galbraith <efault@gmx.de>
To: Martin Lorenz <martin@lorenz.eu.org>
Cc: linux-thinkpad@linux-thinkpad.org, linux-kernel@vger.kernel.org
In-Reply-To: <20061113192738.GE7942@gimli>
References: <20061113081147.GB5289@gimli> <200611131537.01626.rjw@sisk.pl>
	 <20061113192738.GE7942@gimli>
Content-Type: text/plain
Date: Tue, 14 Nov 2006 08:11:23 +0100
Message-Id: <1163488283.16079.18.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-13 at 20:27 +0100, Martin Lorenz wrote:
> On Mon, Nov 13, 2006 at 03:37:01PM +0100, Rafael J. Wysocki wrote:
> > On Monday, 13 November 2006 09:11, Martin Lorenz wrote:
> > > Hallo again,
> > > 
> > > here is another one:
> > > 
> > > I reported a black screen on resume with my latest kernel build earlyer. But
> > > this was not reproducible. Only occured once.
> > 
> > Is this a resume from disk?  If so, which kernel are you using?
> > 
> 
> no from suspend to ram

Interesting.  See http://lkml.org/lkml/2006/10/3/19

	-Mike

