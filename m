Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263561AbUCTWjz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 17:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263565AbUCTWjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 17:39:55 -0500
Received: from waste.org ([209.173.204.2]:45215 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263561AbUCTWjx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 17:39:53 -0500
Date: Sat, 20 Mar 2004 16:39:48 -0600
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       celinux-dev@tree.celinuxforum.org
Subject: 2.6.5-rc2-tiny1 for small systems
Message-ID: <20040320223948.GU11010@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the latest release of the -tiny kernel tree. The aim of this
tree is to collect patches that reduce kernel disk and memory
footprint as well as tools for working on small systems. Target users
are things like embedded systems, small or legacy desktop folks, and
handhelds.

This release is primarily a resync with 2.6.5-rc2. I have reordered
the patches and their config options in preparation for merging
various pieces. This also contains my latest inflate cleanups as well
as a bunch of other minor fixes.

The patch can be found at:

 http://selenic.com/tiny/2.6.5-rc2-tiny1.patch.bz2
 http://selenic.com/tiny/2.6.5-rc2-tiny1-broken-out.tar.bz2

Webpage for your bookmarking pleasure:

 http://selenic.com/tiny-about/

I've also stuck one of my testing configs at:

 http://selenic.com/tiny/sample-config

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
