Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbVGLHVl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbVGLHVl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 03:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbVGLHVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 03:21:41 -0400
Received: from waste.org ([216.27.176.166]:63675 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261242AbVGLHVe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 03:21:34 -0400
Date: Tue, 12 Jul 2005 00:21:31 -0700
From: Matt Mackall <mpm@selenic.com>
To: mercurial@selenic.com, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Mercurial SCM v0.6b released
Message-ID: <20050712072131.GQ12006@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mercurial is a clean, scalable, distributed SCM designed to meet the
needs of large projects like the Linux kernel.

It's only been two weeks since the last release, but development has
been rapid and I've gotten numerous requests to push out a new
release. You can download it at:

 http://selenic.com/mercurial/release/mercurial-0.6b.tar.gz

A Linux kernel repository synced with Linus' tree and with history
back to 2.4.0 is available at:

 http://www.kernel.org/hg/

More information available at:

 http://selenic.com/mercurial/

What's new:

improved ui
 new clone command replaces mkdir+init+pull+update
 new revert command
 add range support and -p option to log to show patches
 tags command now supports local tags
 improved push and pull
 better exception and signal handling
 improved option parsing
 support for user-defined hooks (aka triggers)
performance updates
 even faster import of large sets of patches
 faster delta generation
 faster annotate
 faster status and ignore
improved web interface
 more conformant and compatible HTML output
 built-in RSS feeds
 better tags handling
 fast multiple keyword search
portability work
 support for Windows is nearly complete
 should easily compile and install on any modern UNIX
 comes with RPM spec file and script
and more
 doc and help updates
 improved test suite
 numerous bug fixes and cleanups

Many thanks to all the people that contributed to this release with
code and testing!

-- 
Mathematics is the supreme nostalgia of our time.
