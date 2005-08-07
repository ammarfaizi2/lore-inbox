Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752800AbVHGXvD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752800AbVHGXvD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 19:51:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752845AbVHGXvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 19:51:03 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:64902 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1752800AbVHGXvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 19:51:03 -0400
Message-ID: <42F69E53.40602@gmail.com>
Date: Mon, 08 Aug 2005 01:50:43 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rolf Eike Beer <eike-kernel@sf-tec.de>
Subject: [PATCH] Removing maintainer's bad e-mails
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes 2 e-mails, which aren't right and 1 web address, which returns 404.
[comtrol was posted by Rolf Eike Beer]

It is made in 2.6.13-rc5-mm1, but it should be applicable in other trees too.

Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>
Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>

This patch was posted yet on:
21 Jul 2005

diff --git a/MAINTAINERS b/MAINTAINERS
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -204,8 +204,6 @@ S:	Maintained
 
 ADVANSYS SCSI DRIVER
 P:	Bob Frey
-M:	linux@advansys.com
-W:	http://www.advansys.com/linux.html
 L:	linux-scsi@vger.kernel.org
 S:	Maintained
 
@@ -1975,7 +1973,6 @@ S:	Supported
 
 ROCKETPORT DRIVER
 P:	Comtrol Corp.
-M:	support@comtrol.com
 W:	http://www.comtrol.com
 S:	Maintained
 

-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
241B347EC88228DE51EE A49C4A73A25004CB2A10

