Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263914AbTE3St3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 14:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263915AbTE3St3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 14:49:29 -0400
Received: from us01-fw3-ext.synopsys.com ([204.176.21.196]:7888 "EHLO
	piper.synopsys.com") by vger.kernel.org with ESMTP id S263914AbTE3St1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 14:49:27 -0400
Date: Fri, 30 May 2003 12:02:31 -0700
From: Joe Buck <jbuck@synopsys.com>
To: Bernd Jendrissek <berndj@prism.co.za>
Cc: Kendrick Hamilton <hamilton@sedsystems.ca>, gcc@gcc.gnu.org,
       linux-kernel@vger.kernel.org
Subject: Re: Problem Installing Linux Kernel Module compiled with gcc-3.2.x
Message-ID: <20030530120231.A1328@synopsys.com>
References: <Pine.LNX.4.44.0305300919510.3613-100000@sw-55.sedsystems.ca> <20030530192240.A7564@prism.co.za> <20030530103329.A848@synopsys.com> <20030530204332.C7564@prism.co.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030530204332.C7564@prism.co.za>; from berndj@prism.co.za on Fri, May 30, 2003 at 08:43:32PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 30, 2003 at 08:43:32PM +0200, Bernd Jendrissek wrote:
> > Is there any reason, other than the above-described bit of evil, for doing
> > this (forbidding mixing)?  It prevents the bug-finding approach I
> > described earlier (a binary search for finding miscompiled code) from
> > working.
> 
> Between GCC 2.x and 3.x the *major* version changed (duh).  I would
> imagine that people are/were (justifiably?) concerned that ABI's might
> have changed.  From your response, I assume there are no ABI changes
> for C at least?  I suppose a gratuitous ABI change would constitute a
> bug, though...

There are no ABI changes for C.
