Return-Path: <linux-kernel-owner+w=401wt.eu-S965108AbXAJVU0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965108AbXAJVU0 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 16:20:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965107AbXAJVU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 16:20:26 -0500
Received: from pne-smtpout3-sn1.fre.skanova.net ([81.228.11.120]:54163 "EHLO
	pne-smtpout3-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965106AbXAJVUZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 16:20:25 -0500
Message-ID: <45A55894.3050205@refactor.fi>
Date: Wed, 10 Jan 2007 23:20:20 +0200
From: Leonard Norrgard <leonard.norrgard@refactor.fi>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: Eng.Linux@digi.com, netdev@vger.kernel.org
CC: trivial@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS, use the correct "Orphan" rather than "Orphaned"
Content-Type: multipart/mixed;
 boundary="------------010909050405050003050805"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010909050405050003050805
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Simplify automatic parsing of MAINTAINERS, by using the correct "Orphan"
rather than "Orphaned".

Signed-off-by: Leonard Norrgård <leonard.norrgard@refactor.fi>



--------------010909050405050003050805
Content-Type: text/x-patch;
 name="maintainers-format.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="maintainers-format.patch"

diff --git a/MAINTAINERS b/MAINTAINERS
index 4ccc5fa..7595bc8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1031,13 +1031,13 @@ P:	Digi International, Inc
 M:	Eng.Linux@digi.com
 L:	Eng.Linux@digi.com
 W:	http://www.digi.com
-S:	Orphaned
+S:	Orphan
 
 DIGI RIGHTSWITCH NETWORK DRIVER
 P:	Rick Richardson
 L:	netdev@vger.kernel.org
 W:	http://www.digi.com
-S:	Orphaned
+S:	Orphan
 
 DIRECTORY NOTIFICATION
 P:	Stephen Rothwell

--------------010909050405050003050805--
