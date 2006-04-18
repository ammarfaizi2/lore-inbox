Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbWDRWMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbWDRWMr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 18:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbWDRWMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 18:12:47 -0400
Received: from cantor2.suse.de ([195.135.220.15]:64399 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750720AbWDRWMq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 18:12:46 -0400
Date: Tue, 18 Apr 2006 15:11:34 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: torvalds@osdl.org
Subject: Linux 2.6.16.8
Message-ID: <20060418221134.GA506@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We (the -stable team) are announcing the release of the 2.6.16.8 kernel.

The diffstat and short summary of the fixes are below.

I'll also be replying to this message with a copy of the patch between
2.6.16.7 and 2.6.16.8, as it is small enough to do so.

The updated 2.6.16.y git tree can be found at:
 	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git
and can be browsed at the normal kernel.org git web browser:
	www.kernel.org/git/

thanks,

greg k-h

--------

 Makefile         |    2 +-
 net/ipv4/route.c |    5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

Summary of changes from v2.6.16.7 to v2.6.16.8
==============================================

Greg Kroah-Hartman:
      Linux 2.6.16.8

Stephen Hemminger:
      ip_route_input panic fix (CVE-2006-1525)

