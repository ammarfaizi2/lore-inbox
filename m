Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269006AbUJKOxD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269006AbUJKOxD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 10:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269014AbUJKOwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 10:52:36 -0400
Received: from colin2.muc.de ([193.149.48.15]:61188 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S269006AbUJKOuX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 10:50:23 -0400
Date: 11 Oct 2004 16:50:22 +0200
Date: Mon, 11 Oct 2004 16:50:22 +0200
From: Andi Kleen <ak@muc.de>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, Tim Cambrant <cambrant@acc.umu.se>,
       akpm@digeo.com
Subject: Re: 2.6.9-rc4-mm1
Message-ID: <20041011145022.GA52120@muc.de>
References: <2O5L3-5Jq-11@gated-at.bofh.it> <2O6Ho-6ra-51@gated-at.bofh.it> <m3zn2tv35o.fsf@averell.firstfloor.org> <200410111538.33299.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410111538.33299.rjw@sisk.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2004 at 03:38:32PM +0200, Rafael J. Wysocki wrote:
> On Monday 11 of October 2004 14:40, Andi Kleen wrote:
> > Tim Cambrant <cambrant@acc.umu.se> writes:
> > 
> > > On Mon, Oct 11, 2004 at 03:25:02AM -0700, Andrew Morton wrote:
> > >>
> > >> optimize-profile-path-slightly.patch
> > >>   Optimize profile path slightly
> > >>
> > >
> > > I'm still getting an oops at startup with this patch. After reversing
> > > it, everything is fine. Weren't you supposed to remove that from your
> > > tree until it was fixed?
> > 
> > There's a fixed version around. I thought Andrew had merged that one?
> [-- snip --]
> 
> This one does not apply to -mm.

You have to revert the previous version first.

-Andi
