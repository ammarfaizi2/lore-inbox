Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbVALEpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbVALEpT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 23:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261247AbVALEpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 23:45:19 -0500
Received: from smtp104.rog.mail.re2.yahoo.com ([206.190.36.82]:20652 "HELO
	smtp104.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261232AbVALEpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 23:45:10 -0500
Subject: [PATCH] (trivial) spelling fix in comment in Makefile
From: John Kacur <jkacur@rogers.com>
Reply-To: jkacur@rogers.com
To: kai@germaschewski.name, sam@ravnborg.org
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Content-Type: text/plain
Message-Id: <1105504445.5047.46.camel@linux.site>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 11 Jan 2005 23:34:05 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please apply

--- linux-2.6.10/Makefile.orig	2005-01-11 22:45:30.971843616 -0500
+++ linux-2.6.10/Makefile	2005-01-11 22:58:55.627517360 -0500
@@ -18,7 +18,7 @@
 #
 # Most importantly: sub-Makefiles should only ever modify files in
 # their own directory. If in some directory we have a dependency on
-# a file in another dir (which doesn't happen often, but it's of
+# a file in another dir (which doesn't happen often, but it's often
 # unavoidable when linking the built-in.o targets which finally
 # turn into vmlinux), we will call a sub make in that other dir, and
 # after that we are sure that everything which is in that other dir


