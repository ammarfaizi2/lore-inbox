Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268231AbUGXCGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268231AbUGXCGr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 22:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268233AbUGXCGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 22:06:47 -0400
Received: from waste.org ([209.173.204.2]:43975 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S268231AbUGXCGq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 22:06:46 -0400
Date: Fri, 23 Jul 2004 21:06:44 -0500
From: Matt Mackall <mpm@selenic.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] ketchup 0.8
Message-ID: <20040724020644.GN18675@waste.org>
References: <20040723185504.GJ18675@waste.org> <1090632808.1471.20.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1090632808.1471.20.camel@mindpipe>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2004 at 09:33:28PM -0400, Lee Revell wrote:
> On Fri, 2004-07-23 at 14:55, Matt Mackall wrote:
> > ketchup is a script that automatically patches between kernel
> > versions, downloading and caching patches as needed, and automatically
> > determining the latest versions of several trees. Available at:
> > 
> >  http://selenic.com/ketchup/ketchup-0.8
> > 
> 
> Does not work on Debian unstable:

Oops. Should be fixed by:

http://selenic.com/ketchup/ketchup-0.8.1

-- 
Mathematics is the supreme nostalgia of our time.
