Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261182AbULDWat@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbULDWat (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 17:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261183AbULDWat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 17:30:49 -0500
Received: from waste.org ([209.173.204.2]:1225 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261182AbULDWap (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 17:30:45 -0500
Date: Sat, 4 Dec 2004 14:30:40 -0800
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>, linux-tiny@selenic.com,
       celinux-dev@tree.celinuxforum.org
Subject: 2.6.9-tiny1 (finally)
Message-ID: <20041204223040.GL2460@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a resync of the -tiny tree against 2.6.9. Lots of minor
bugfixes and cleanups. This also now includes kexec and crashdump
support from -mm as well as the reintroduction of the sysfs backing
store patches. Enjoy!

The latest patch can be found at:

 http://selenic.com/tiny/2.6.9-tiny1.patch.bz2
 http://selenic.com/tiny/2.6.9-tiny1-broken-out.tar.bz2

There's a mailing list for linux-tiny development at:
 
 linux-tiny at selenic.com
 http://selenic.com/mailman/listinfo/linux-tiny

Webpage for your bookmarking pleasure:

 http://selenic.com/tiny-about/

-- 
Mathematics is the supreme nostalgia of our time.
