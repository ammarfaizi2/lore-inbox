Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272311AbTHDXum (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 19:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272312AbTHDXum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 19:50:42 -0400
Received: from mta1.srv.hcvlny.cv.net ([167.206.5.4]:33066 "EHLO
	mta1.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S272311AbTHDXul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 19:50:41 -0400
Date: Mon, 04 Aug 2003 19:50:35 -0400
From: "Josef 'Jeff' Sipek" <jeffpc@optonline.net>
Subject: [PATCH][TRIVIAL][2.6] Bugzilla bug # 993 - Documentation/Changes still
 reads 2.5
To: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <200308041950.35913.jeffpc@optonline.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.5.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One additional change of kernel version numbers (2.5 -> 2.6.) As I said already, this should
be "fixed" now, so that we don't have to think about trivial patches like this one later.

Josef "Jeff" Sipek

--- linux-2.6.0-test2-vanilla/Documentation/Changes	2003-07-27 13:09:27.000000000 -0400
+++ linux-2.6.0-test2-tmp/Documentation/Changes	2003-07-27 15:18:28.000000000 -0400
@@ -2,7 +2,7 @@
 =====
 
 This document is designed to provide a list of the minimum levels of
-software necessary to run the 2.5 kernels, as well as provide brief
+software necessary to run the 2.6 kernels, as well as provide brief
 instructions regarding any other "Gotchas" users may encounter when
 trying life on the Bleeding Edge.  If upgrading from a pre-2.4.x
 kernel, please consult the Changes file included with 2.4.x kernels for

