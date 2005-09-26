Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932474AbVIZT5L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932474AbVIZT5L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 15:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932486AbVIZT5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 15:57:10 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:41151 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932474AbVIZT5J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 15:57:09 -0400
Date: Mon, 26 Sep 2005 12:57:03 -0700 (PDT)
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Simon Derr <Simon.Derr@bull.net>,
       Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org
Message-Id: <20050926195702.8045.53635.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH] cpuset maintainers
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Specify the cpuset maintainers.

Signed-off-by: Paul Jackson <pj@sgi.com>
Signed-off-by: Simon Derr <simon.derr@bull.net>

Index: 2.6.13-mm3-migrate-mempolicy/MAINTAINERS
===================================================================
--- 2.6.13-mm3-migrate-mempolicy.orig/MAINTAINERS
+++ 2.6.13-mm3-migrate-mempolicy/MAINTAINERS
@@ -602,6 +602,15 @@ P:	H. Peter Anvin
 M:	hpa@zytor.com
 S:	Maintained
 
+CPUSETS
+P:	Paul Jackson
+P:	Simon Derr
+M:	pj@sgi.com
+M:	simon.derr@bull.net
+L:	linux-kernel@vger.kernel.org
+W:	http://www.bullopensource.org/cpuset/
+S:	Supported
+
 CRAMFS FILESYSTEM
 W:     http://sourceforge.net/projects/cramfs/
 S:     Orphan

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
