Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263614AbUD0AmW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263614AbUD0AmW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 20:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263621AbUD0AmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 20:42:22 -0400
Received: from fw.osdl.org ([65.172.181.6]:57824 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263614AbUD0AmV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 20:42:21 -0400
Date: Mon, 26 Apr 2004 17:41:02 -0700
From: Chris Wright <chrisw@osdl.org>
To: Jesse Barnes <jbarnes@sgi.com>
Cc: linux-kernel@vger.kernel.org, Chris Wright <chrisw@osdl.org>,
       Erik Jacobson <erikj@subway.americas.sgi.com>
Subject: Re: [PATCH] Process Aggregates (PAGG) support for the 2.6 kernel
Message-ID: <20040426174102.S22989@build.pdx.osdl.net>
References: <Pine.SGI.4.53.0404261656230.591647@subway.americas.sgi.com> <20040426163955.X21045@build.pdx.osdl.net> <200404261736.47522.jbarnes@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200404261736.47522.jbarnes@sgi.com>; from jbarnes@sgi.com on Mon, Apr 26, 2004 at 05:36:47PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jesse Barnes (jbarnes@sgi.com) wrote:
> On Monday, April 26, 2004 4:39 pm, Chris Wright wrote:
> > * Erik Jacobson (erikj@subway.americas.sgi.com) wrote:
> > > Here, I am proposing Process Aggregates support for the 2.6 kernel.
> >
> > This looks like it's just the infrastructure, i.e. nothing is using it.
> > It seems like PAGG could be done on top of CKRM (albeit, with more
> > code).  But if the goal is to do some basic accounting, scheduling, etc.
> > on a resource group, wouldn't CKRM be more generic?
> 
> Quite possibly.  Do you have a pointer to the latest bits/design docs?

Nothing aside from what's on ckrm.sf.net.  I know they've been retooling
it a bit, but I'm not up on the current status.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
