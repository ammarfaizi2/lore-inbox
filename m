Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261756AbUCPWZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 17:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbUCPWZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 17:25:56 -0500
Received: from waste.org ([209.173.204.2]:38344 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261756AbUCPWZy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 17:25:54 -0500
Date: Tue, 16 Mar 2004 16:25:49 -0600
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       celinux-dev@tree.celinuxforum.org
Subject: 2.6.5-rc1-tiny1 for small systems
Message-ID: <20040316222548.GD11010@waste.org>
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

This release is primarily a resync with 2.6.5-rc1 and contains various
compile fixes and other cleanups.

The patch can be found at:

 http://selenic.com/tiny/2.6.5-rc1-tiny1.patch.bz2
 http://selenic.com/tiny/2.6.5-rc1-tiny1-broken-out.tar.bz2

Webpage for your bookmarking pleasure:

 http://selenic.com/tiny-about/

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
