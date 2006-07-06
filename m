Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750943AbWGFW3m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943AbWGFW3m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 18:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750947AbWGFW3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 18:29:42 -0400
Received: from ns2.suse.de ([195.135.220.15]:27034 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750943AbWGFW3l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 18:29:41 -0400
Date: Thu, 6 Jul 2006 15:25:53 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, stable@kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Linux 2.6.16.24
Message-ID: <20060706222553.GA2946@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We (the -stable team) are announcing the release of the 2.6.16.24 kernel.

I'll also be replying to this message with a copy of the patch between
2.6.16.23 and 2.6.16.24, as it is small enough to do so.

The updated 2.6.16.y git tree can be found at:
 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git
and can be browsed at the normal kernel.org git web browser:
	www.kernel.org/git/

thanks,

greg k-h

--------


 Makefile     |    2 +-
 kernel/sys.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Summary of changes from v2.6.16.23 to v2.6.16.24
================================================

Greg Kroah-Hartman:
      fix prctl privilege escalation and suid_dumpable (CVE-2006-2451)
      Linux 2.6.16.24

