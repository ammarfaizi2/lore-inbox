Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266505AbUH0QXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266505AbUH0QXy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 12:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266479AbUH0QXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 12:23:53 -0400
Received: from fire.osdl.org ([65.172.181.4]:52368 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S266505AbUH0QWQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 12:22:16 -0400
Subject: Re: 2 New compile/sparse warnings (nightly build)
From: John Cherry <cherry@osdl.org>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20040827152551.GI21964@parcelfarce.linux.theplanet.co.uk>
References: <1093619350.2467.17.camel@cherrybomb.pdx.osdl.net>
	 <20040827152551.GI21964@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Message-Id: <1093623471.2467.50.camel@cherrybomb.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 27 Aug 2004 09:17:51 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-08-27 at 08:25, viro@parcelfarce.linux.theplanet.co.uk
wrote:
> On Fri, Aug 27, 2004 at 08:09:10AM -0700, John Cherry wrote:
> > Summary:
> >    New warnings = 2
> >    Fixed warnings = 8
>  
> Hmm...  What .config are you using?  There was a bunch of sound/oss
> check_region() removals, etc.

Al, this summary is just a for a daily build (24-hour period).  I only
post this when new warnings appear.  There have been a bunch of fixed
warning over the past several weeks that have not been posted.

> 
> Here I'm running builds on allmodconfig and allomodconfig with added
> 'SMP depends on BROKEN' to catch the BROKEN_ON_SMP drivers.

