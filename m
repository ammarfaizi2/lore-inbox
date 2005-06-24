Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263142AbVFXV3m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263142AbVFXV3m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 17:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263278AbVFXV3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 17:29:30 -0400
Received: from waste.org ([216.27.176.166]:59607 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263267AbVFXVYP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 17:24:15 -0400
Date: Fri, 24 Jun 2005 14:24:07 -0700
From: Matt Mackall <mpm@selenic.com>
To: mercurial@selenic.com, linux-kernel <linux-kernel@vger.kernel.org>,
       git@vger.kernel.org
Subject: Mercurial 0.6 released!
Message-ID: <20050624212407.GV27572@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is release 0.6 of Mercurial, the distributed SCM.

Mercurial is:
 - fast: as fast or faster than git or others for all important operations
 - easy to use: familiar commands, integrated help, integrated web server
 - space efficient: Linux kernel history back to 2.4.0 in 300MB
 - bandwidth efficient: 120MB to transfer that history
 - distributed: supports decentralized development with arbitrary merging
 - scalable: handles large numbers of files and revisions effortlessly
 - robust: append-only storage model with journalling and rollback
 - lightweight: small Python codebase

Available at http://selenic.com/mercurial/
Linux kernel repository at http://www.kernel.org/hg/

This release contains a huge number of improvements:

improved source tracking
  multi-head support
  permission tracking
  rename and copy tracking
  improved tag handling
friendlier, more robust command line interface
  integrated help
  faster startup
  better exception handling
  smarter three-way merge helper
improved communication
  faster outstanding changeset detection
  SSH-based push support
  non-transparent proxy support
improved configuration handling
  support for .hgrc and .hg/hgrc files
  save per-repo defaults for pull
new delta extension
  faster, smaller, and simpler than GNU diff or xdiff
  faster commit, push/pull, and annotate
improved interoperability
  convert-repo framework for importing from other SCMs 
  can work with gitk and git-viz
portability improvements
  tested on big and little-endian 32 and 64-bit UNIX platforms
  Windows support is nearly complete
and much more
  numerous performance tweaks and bugfixes
  automated test suite
  updated docs and FAQ


-- 
Mathematics is the supreme nostalgia of our time.
