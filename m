Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbUCPVN3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 16:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261689AbUCPVN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 16:13:29 -0500
Received: from mx1.redhat.com ([66.187.233.31]:42389 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261681AbUCPVNY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 16:13:24 -0500
To: aoliva@redhat.com
Subject: [patch] for the NEWS file: Larissa Garcia Oliva
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat Global Engineering Services Compiler Team
Date: 16 Mar 2004 18:09:34 -0300
Message-ID: <ord67c7b3l.fsf@livre.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This new project has been under development for quite some time, and
the release date has finally arrived.  It's not exactly related with
previous projects I've been involved with, but I thought you might be
interested.  I've enclosed some snippets of the following patch; more
details in the URL in the signature.

Index: ChangeLog
2004-03-13  Alexandre Oliva  <aoliva@redhat.com>,  Islene C. Garcia

	* Larissa Garcia Oliva: New.
	* NEWS: Adjust.

Index: NEWS
--- /dev/null	2004-02-23 18:02:56.000000000 -0300
+++ NEWS	2004-03-16 17:42:49.870247754 -0300
@@ -0,0 +1,8 @@
+Final Release - March 13, 2004
+
+* combined features from Islene Calciolari Garcia and Alexandre Oliva
+
+* completed fork(), optimized sleep() and implemented several new I/O
+  interfaces
+
+Download size: 3.895Kg, 49.5cm

-- 
Alexandre Oliva             http://www.ic.unicamp.br/~oliva/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}
