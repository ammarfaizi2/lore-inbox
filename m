Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270662AbTHAEjl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 00:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270663AbTHAEjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 00:39:41 -0400
Received: from lightning.hereintown.net ([141.157.132.3]:34777 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id S270662AbTHAEjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 00:39:40 -0400
Subject: Re: xfs problems (2.6.0-test2)
From: Chris Meadors <clubneon@hereintown.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20030801024041.GA732@frodo>
References: <200308010431.56108.mzielinski@wp-sa.pl>
	 <20030801024041.GA732@frodo>
Content-Type: text/plain
Message-Id: <1059712682.1982.3.camel@clubneon.clubneon.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 01 Aug 2003 00:38:02 -0400
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19iRhb-00076c-PH*n0I/MXENkqw*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-07-31 at 22:40, Nathan Scott wrote:
> Hi there,
> 
> What XFS blocksize are you using, and what is your page size?
> There are known issues when using blocksizes smaller than the
> page size in the 2.6 XFS code at the moment.
> 
> Feel free to open bugs for this and your repair problems on the
> XFS site on oss.sgi.com; the gdb backtrace of the failed repair
> attempts will be useful as well.

I believe there was a post this past weekend about block sizes (or maybe
fragment sizes) on the Opteron.  It wasn't with XFS I'm pretty sure.  I
tried searching for it, but can't find it again.

I'm going to start playing with an Opteron pretty soon.  I will be using
XFS.  What are the recommended settings when creating file systems?

-- 
Chris

