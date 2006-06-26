Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933092AbWFZWTD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933092AbWFZWTD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933097AbWFZWTB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:19:01 -0400
Received: from web50115.mail.yahoo.com ([206.190.39.163]:46251 "HELO
	web50115.mail.yahoo.com") by vger.kernel.org with SMTP
	id S933092AbWFZWS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:18:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=iSaC+uvABXlOxRbz/VA5IrW8680r1SduuUBZ9OcWEbUwiwJDmjiGlchpQBwcDJz1nb4g0XhPBsVUPs/+s9PNumT44FMiqouOXtZSmJH0FqtnTPZerCyLaHedG5MfKAMwjAqLPDR9k+NNKcLvPPxMayIxJ8bAtQNTR+W7CB0xnTI=  ;
Message-ID: <20060626221858.13017.qmail@web50115.mail.yahoo.com>
Date: Mon, 26 Jun 2006 15:18:58 -0700 (PDT)
From: Doug Thompson <norsk5@yahoo.com>
Subject: [PATCH 6/6]  EDAC maintainers update
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Doug Thompson <norsk5@xmission.com>

Removed Dave Peterson as per his request as co-maintainer of EDAC
Thanks Dave.
Added Mark Gross as maintainer of edac-e752x driver
Thanks Mark

Signed-off-by:	Doug Thompson <norsk5@xmission.com>
Signed-off-by:	Dave Peterson <dsp@llnl.gov>
Signed-off-by:	Mark Gross <mark.gross@intel.com>
---

 MAINTAINERS |   14 ++++++--------
 1 files changed, 6 insertions(+), 8 deletions(-)


Index: linux-2.6.17-rc6/MAINTAINERS
===================================================================
--- linux-2.6.17-rc6.orig/MAINTAINERS	2006-06-09 16:44:02.000000000 -0600
+++ linux-2.6.17-rc6/MAINTAINERS	2006-06-12 17:42:24.000000000 -0600
@@ -913,23 +913,21 @@
 
 EDAC-CORE
 P:	Doug Thompson
-M:	norsk5@xmission.com, dthompson@linuxnetworx.com
-P:	Dave Peterson
-M:	dsp@llnl.gov, dave_peterson@pobox.com
+M:	norsk5@xmission.com
 L:	bluesmoke-devel@lists.sourceforge.net
 W:	bluesmoke.sourceforge.net
-S:	Maintained
+S:	Supported
 
 EDAC-E752X
-P:	Dave Peterson
-M:	dsp@llnl.gov, dave_peterson@pobox.com
+P:	Mark Gross
+M:	mark.gross@intel.com
 L:	bluesmoke-devel@lists.sourceforge.net
 W:	bluesmoke.sourceforge.net
 S:	Maintained
 
 EDAC-E7XXX
-P:	Dave Peterson
-M:	dsp@llnl.gov, dave_peterson@pobox.com
+P:	Doug Thompson
+M:	norsk5@xmission.com
 L:	bluesmoke-devel@lists.sourceforge.net
 W:	bluesmoke.sourceforge.net
 S:	Maintained

