Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271809AbTGROzB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 10:55:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271807AbTGROyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 10:54:16 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:33157
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S271810AbTGRONc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 10:13:32 -0400
Date: Fri, 18 Jul 2003 15:27:53 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307181427.h6IERrmJ017838@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: correct author of ad1980 plugin
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Overzealous C&P of Red Hat license template 8))
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test1/sound/oss/ac97_plugin_ad1980.c linux-2.6.0-test1-ac2/sound/oss/ac97_plugin_ad1980.c
--- linux-2.6.0-test1/sound/oss/ac97_plugin_ad1980.c	2003-07-14 14:11:57.000000000 +0100
+++ linux-2.6.0-test1-ac2/sound/oss/ac97_plugin_ad1980.c	2003-07-14 14:39:26.000000000 +0100
@@ -17,7 +17,7 @@
    the provisions above, a recipient may use your version of this
    file under either the OSL or the GPL.
    
-   Authors: 	Arjan van de Ven <arjanv@redhat.com>
+   Authors: 	Alan Cox <alan@redhat.com>
 
    This is an example codec plugin. This one switches the connections
    around to match the setups some vendors use with audio switched to
