Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965008AbWDHDZV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965008AbWDHDZV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 23:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965010AbWDHDZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 23:25:21 -0400
Received: from hierophant.serpentine.com ([66.92.13.71]:42656 "EHLO
	demesne.serpentine.com") by vger.kernel.org with ESMTP
	id S965008AbWDHDZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 23:25:21 -0400
Subject: [ANNOUNCE] Mercurial 0.8.1 released
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 07 Apr 2006 20:26:03 -0700
Message-Id: <1144466763.20678.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Version 0.8.1 of the Mercurial distributed revision control system is
now available. This release features numerous usability improvements,
performance enhancements, and bug fixes over previous releases.

More information about Mercurial, including information on downloading
sources and binaries can be found at:

 http://www.selenic.com/mercurial/

The Mercurial mirror of Linus's kernel git tree is available at:

 http://www.kernel.org/hg/linux-2.6/

Many thanks to Mercurial contributors and supporters for making the
continued rapid improvement of this software possible!

Major changes from 0.8 to 0.8.1:

- new extensions:
  mq (manage a queue of patches, like quilt only better)
  email (send changes as series of email patches)
- new command: merge (replaces "update -m")
- improved commands: log (--limit option added), pull/push ("-r" works
  on specific revisions), revert (rewritten, much better)
- comprehensive hook support
- output templating added, supporting e.g. GNU changelog style
- Windows, Mac OS X: prebuilt binary packages, better support
- many reliability, performance, and memory usage improvements

For help, visit the web site or #mercurial on irc.freenode.net
-- 
Bryan O'Sullivan <bos@serpentine.com>

