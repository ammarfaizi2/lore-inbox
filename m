Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266065AbUAFFtE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 00:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266068AbUAFFtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 00:49:04 -0500
Received: from waste.org ([209.173.204.2]:4304 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S266065AbUAFFtA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 00:49:00 -0500
Date: Mon, 5 Jan 2004 23:48:59 -0600
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.1-rc1-tiny2
Message-ID: <20040106054859.GA18208@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the fourth release of the -tiny kernel tree. The aim of this
tree is to collect patches that reduce kernel disk and memory
footprint as well as tools for working on small systems. Target users
are things like embedded systems, small or legacy desktop folks, and
handhelds.

Latest release includes:
 - various compile fixes for last release
 - actually include Andi Kleen's bloat-o-meter this time
 - optional mempool removal
 - optional semaphore uninlining
 - optional linux socket filter
 - reduced flow cache
 - optional device multicast management
 - optional rtnetlink/af_netlink
 - optional IGMP
 - optional POSIX timer API
 - inline cleanup in fs/namei.c

The patch can be found at:

 http://selenic.com/tiny/2.6.1-rc1-tiny2.patch.bz2
 http://selenic.com/tiny/2.6.1-rc1-tiny2-broken-out.tar.bz2

Webpage for your bookmarking pleasure:

 http://selenic.com/tiny-about/

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
