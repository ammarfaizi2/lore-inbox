Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261331AbVAGOEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261331AbVAGOEp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 09:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261319AbVAGOEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 09:04:44 -0500
Received: from [212.20.225.142] ([212.20.225.142]:6207 "EHLO
	orlando.wolfsonmicro.main") by vger.kernel.org with ESMTP
	id S261426AbVAGODI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 09:03:08 -0500
Subject: [PATCH 5/5] WM97xx touch driver AC97 plugin
From: Liam Girdwood <Liam.Girdwood@wolfsonmicro.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-2PFnEs7HmIXqFB6suAGt"
Message-Id: <1105106587.9143.1009.camel@cearnarfon>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 07 Jan 2005 14:03:08 +0000
X-OriginalArrivalTime: 07 Jan 2005 14:03:08.0155 (UTC) FILETIME=[9D80DCB0:01C4F4C1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-2PFnEs7HmIXqFB6suAGt
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This is an entry to the MAINTAINERS file for the wm97xx codecs and
touchscreen controllers.

Signed-off-by: Liam Girdwood <liam.girdwood@wolfsonmicro.com>

--=-2PFnEs7HmIXqFB6suAGt
Content-Disposition: attachment; filename=MAINTAINERS.diff
Content-Type: text/x-patch; name=MAINTAINERS.diff; charset=
Content-Transfer-Encoding: 7bit

--- a/MAINTAINERS	2004-12-24 21:35:00.000000000 +0000
+++ b/MAINTAINERS	2005-01-05 16:59:27.000000000 +0000
@@ -2533,6 +2533,12 @@
 W:	http://advogato.org/person/acme
 S:	Maintained
 
+WOLFSON AUDIO CODECS & TOUCHSCREEN CONTROLLERS
+P:  Liam Girdwood
+M:  liam.girdwood@wolfsonmicro.com
+W:  http://www.wolfsonmicro.com
+S:  Supported
+
 X.25 NETWORK LAYER
 P:	Henner Eisen
 M:	eis@baty.hanse.de

--=-2PFnEs7HmIXqFB6suAGt--

