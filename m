Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267998AbUHUXIH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267998AbUHUXIH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 19:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267999AbUHUXIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 19:08:07 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:43537 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP id S267998AbUHUXID
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 19:08:03 -0400
Date: Sun, 22 Aug 2004 00:08:02 +0100
From: John Levon <levon@movementarian.org>
To: Andrew Morton <akpm@osdl.org>
Cc: oprofile-list@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] OProfile ia64 performance counter support
Message-ID: <20040821230802.GA20175@compsoc.man.ac.uk>
References: <20040821195206.GA10240@compsoc.man.ac.uk> <20040821140016.33900da7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040821140016.33900da7.akpm@osdl.org>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: King of Woolworths - L'Illustration Musicale
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1Byexu-000CQl-7I*jAiwjC1LvVA*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 21, 2004 at 02:00:16PM -0700, Andrew Morton wrote:

> > This patch provides support for IA64 hardware performance counters via
> >  the perfmon interface.
> 
> OK - I'll plop this in -mm but I'd ask Tony to do the final merge as and
> when it suits the ia64 team.
> 
> What's the story on userspace support for oprofile-on-ia64?

It's been merged for quite some time. Changelog indicates that it's
usable starting from 0.7 onwards, but I couldn't be sure.

regards
john
