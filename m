Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbTKGFKu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 00:10:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbTKGFKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 00:10:50 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:14551 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S261433AbTKGFKt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 00:10:49 -0500
Date: Thu, 6 Nov 2003 21:10:48 -0800
From: Larry McVoy <lm@bitmover.com>
To: linux-kernel@vger.kernel.org
Subject: kernel.bkbits.net off the air
Message-ID: <20031107051048.GA6099@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As many of you have figured out, I took kernel.bkbits.net (aka bk.kernel.org,
cvs.kernel.org, and svn.kernel.org) of the air yesterday due to the breakin
that attempted to add a trojan horse to the kernel source.

I took it down after talking with Linus and Dave about it, the point was to
shut down the disk drive so that we can go do forensics on it after the fact
and see what we can figure out.  Maybe someone can track down who caused the
problem.

This means someone has to go down to the colo with a new disk and do
an install and we've been too busy to do this.  Would anyone object if
this wasn't done until this weekend?  We're pretty booked up here with
other work.  Last I checked only about 6 IP addresses where using the CVS
server, I've never checked on the SVN server (Ben?  You have any idea?).
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
