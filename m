Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261991AbVFGVj3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261991AbVFGVj3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 17:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261992AbVFGVj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 17:39:29 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:52474 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261991AbVFGVjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 17:39:22 -0400
Date: Tue, 7 Jun 2005 14:38:55 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc6-mm1: rio confusion
Message-ID: <20050607143854.D26258@cox.net>
References: <20050607042931.23f8f8e0.akpm@osdl.org> <20050607205906.GA7962@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050607205906.GA7962@stusta.de>; from bunk@stusta.de on Tue, Jun 07, 2005 at 10:59:06PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2005 at 10:59:06PM +0200, Adrian Bunk wrote:
> On Tue, Jun 07, 2005 at 04:29:31AM -0700, Andrew Morton wrote:
> >...
> > Changes since 2.6.12-rc5-mm2:
> >...
> > +rapidio-support-core-base.patch
> > +rapidio-support-core-includes.patch
> > +rapidio-support-core-enum.patch
> > +rapidio-support-ppc32.patch
> > +rapidio-support-net-driver.patch
> > 
> >  RapidIO driver
> >...
> 
> That we do now have both drivers/rio/ and drivers/char/rio/ and that 
> they are for completely different things is confusing.
> 
> What about drivers/rapidio/ ?

Fine with me. I'll roll it into my next update.

-Matt
