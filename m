Return-Path: <linux-kernel-owner+w=401wt.eu-S1751561AbWLLROr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751561AbWLLROr (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 12:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751563AbWLLROr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 12:14:47 -0500
Received: from livid.absolutedigital.net ([66.92.46.173]:1716 "EHLO
	mx2.absolutedigital.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751560AbWLLROr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 12:14:47 -0500
Date: Tue, 12 Dec 2006 12:13:47 -0500 (EST)
From: Cal Peake <cp@absolutedigital.net>
To: trivial@kernel.org
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix inotify maintainers entry
Message-ID: <Pine.LNX.4.64.0612121208410.4219@lancer.cnet.absolutedigital.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update the inotify entry in MAINTAINERS to be consistent with the rest of 
the file.

Signed-off-by: Cal Peake <cp@absolutedigital.net>

--- ./MAINTAINERS~orig	2006-12-12 11:44:01.000000000 -0500
+++ ./MAINTAINERS	2006-12-12 12:08:02.000000000 -0500
@@ -1504,8 +1504,10 @@
 S:	Maintained
 
 INOTIFY
-P:	John McCutchan and Robert Love
-M:	ttb@tentacle.dhs.org and rml@novell.com
+P:	John McCutchan
+M:	ttb@tentacle.dhs.org
+P:	Robert Love
+M:	rml@novell.com
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 
