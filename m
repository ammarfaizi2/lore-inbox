Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945989AbWGODD6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945989AbWGODD6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 23:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945986AbWGODDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 23:03:36 -0400
Received: from tomts31.bellnexxia.net ([209.226.175.105]:39133 "EHLO
	tomts31-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1945985AbWGODDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 23:03:34 -0400
Date: Fri, 14 Jul 2006 20:00:47 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, stable@kernel.org
Subject: Linux 2.6.17.5
Message-ID: <20060715030047.GC11167@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We (the -stable team) are announcing the release of the 2.6.17.5 kernel.

I'll also be replying to this message with a copy of the patch between
2.6.17.4 and 2.6.17.5, as it is small enough to do so.

The updated 2.6.17.y git tree can be found at:
 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.17.y.git
and can be browsed at the normal kernel.org git web browser:
	www.kernel.org/git/

thanks,

greg k-h

--------

 Makefile       |    2 +-
 fs/proc/base.c |    1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

Summary of changes from v2.6.17.4 to v2.6.17.5
==============================================

Greg Kroah-Hartman:
      Linux 2.6.17.5

Linus Torvalds:
      Fix nasty /proc vulnerability (CVE-2006-3626)

