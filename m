Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261307AbSJCVV3>; Thu, 3 Oct 2002 17:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261323AbSJCVV3>; Thu, 3 Oct 2002 17:21:29 -0400
Received: from CPEdeadbeef0000.cpe.net.cable.rogers.com ([24.100.232.94]:3076
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S261307AbSJCVV2>; Thu, 3 Oct 2002 17:21:28 -0400
Date: Thu, 3 Oct 2002 17:29:23 -0400 (EDT)
From: Shawn Starr <spstarr@sh0n.net>
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] Patch release - 2.4.20-pre7-rmap14a-shawn12d.1
Message-ID: <Pine.LNX.4.44.0210031728370.11204-100000@coredump.sh0n.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch release
=======================

xfs-2.4.20-pre7-rmap14a-uml-shawn12d.1 against 2.4.19 vanilla. (October 3rd, 2002)

- Fixed KDB compile errors (due to changes in page structure)

- Fixed symbol error (vmap) when not using XFS file system

- Fixed symbol error (grab_cache_page) missing in pagemap.h


you can get it at:

http://xfs.sh0n.net/2.4/testing/linux-shawn12d.1.diff.patch

Note: Site is having connectivity issues right now (the machine looks dead
;))


--
Shawn Starr, sh0n.net, <spstarr@sh0n.net>
Maintainer: -shawn kernel patches: http://xfs.sh0n.net/2.4/

