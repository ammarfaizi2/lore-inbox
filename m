Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264186AbTHDX5a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 19:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272312AbTHDX5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 19:57:30 -0400
Received: from mta7.srv.hcvlny.cv.net ([167.206.5.22]:45787 "EHLO
	mta7.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S264186AbTHDX53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 19:57:29 -0400
Date: Mon, 04 Aug 2003 19:57:24 -0400
From: "Josef 'Jeff' Sipek" <jeffpc@optonline.net>
Subject: [PATCH][TRIVIAL][2.6] Bugzilla bug # 939 - wrong documentation
To: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <200308041957.24169.jeffpc@optonline.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.5.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, this is a simple docs patch. I diffed it against -test1, but the file didn't change
since then.

Josef "Jeff" Sipek

--- linux-2.6.0-test1-vanilla/arch/h8300/README	2003-07-13 23:36:33.000000000 -0400
+++ linux-2.6.0-test1-eva/arch/h8300/README	2003-07-17 02:03:21.000000000 -0400
@@ -16,7 +16,7 @@
 
 3.H8MAX 
   Under development
-  see http://www.strawbelly-linux.com (Japanese Only)
+  see http://www.strawberry-linux.com (Japanese Only)
 
 * Toolchain Version
 gcc-3.1 or higher and patch

