Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261835AbTH2UfJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 16:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261767AbTH2Ucy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 16:32:54 -0400
Received: from itaqui.terra.com.br ([200.176.3.19]:17024 "EHLO
	itaqui.terra.com.br") by vger.kernel.org with ESMTP id S261835AbTH2UcS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 16:32:18 -0400
Message-ID: <3F4FB8A3.4070805@terra.com.br>
Date: Fri, 29 Aug 2003 17:33:39 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kernel-janitor-discuss@lists.sourceforge.net
Subject: [PATCH 4/5] remove unneeded linux/version.h from net/sunrpc
Content-Type: multipart/mixed;
 boundary="------------070808020605080302040207"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070808020605080302040207
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

	Hi,

	This patch was based on Randy's modified checkversion.pl script.

	Compile fine against 2.6.0-test4.

	Please consider applying.

	Cheers,

Felipe

--------------070808020605080302040207
Content-Type: text/plain;
 name="timer.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="timer.patch"

--- linux-2.6.0-test4/net/sunrpc/timer.c.orig	Fri Aug 29 17:16:54 2003
+++ linux-2.6.0-test4/net/sunrpc/timer.c	Fri Aug 29 17:17:56 2003
@@ -15,7 +15,6 @@
 
 #include <asm/param.h>
 
-#include <linux/version.h>
 #include <linux/types.h>
 #include <linux/unistd.h>
 

--------------070808020605080302040207--

