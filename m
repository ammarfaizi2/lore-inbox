Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264298AbUHGVwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264298AbUHGVwy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 17:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264388AbUHGVwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 17:52:54 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:15319 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S264298AbUHGVww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 17:52:52 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-O3
From: Lee Revell <rlrevell@joe-job.com>
To: noreply@vt.shuis.tudelft.nl
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200408072343.53852.noreply@vt.shuis.tudelft.nl>
References: <200408072343.53852.noreply@vt.shuis.tudelft.nl>
Content-Type: text/plain
Message-Id: <1091915576.894.15.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 07 Aug 2004 17:52:56 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-08-07 at 17:43, Remon wrote:
> > /dev/psaux is deprecated.  Use /dev/input/mice.  On Debian, you can do
> > this with `dpkg-reconfigure xserver-xfree86'.  Otherwise, use your
> > distro's X configurator, or edit /etc/X11/XF86Config-4 and replace
> > /dev/psaux with /dev/input/mice.
> 
> However, I still have problems, especially with the mouse. I used my computer 
> for a while and suddenly the mouse got wild so to say.
> It jumped back and forth, starting applications, kinda funny to see actually.

Please do not use a 'noreply' address to post to LKML.  It's rude.

Is this in fact a PS/2 mouse, or USB?

Lee



