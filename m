Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262719AbUCOT3b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 14:29:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262703AbUCOT1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 14:27:48 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:13276 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S262719AbUCOT1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 14:27:25 -0500
Date: Mon, 15 Mar 2004 19:27:06 GMT
Message-Id: <200403151927.i2FJR6bc015706@delerium.codemonkey.org.uk>
From: davej@redhat.com
To: linux-kernel@vger.kernel.org
Subject: [ALSA][5/6] Misc cleanups
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miscellaneous junk, indentation fixes and the like.

		Dave

--- linux-2.6.4/sound/isa/sb/es968.c~	2004-03-15 18:21:46.000000000 +0000
+++ linux-2.6.4/sound/isa/sb/es968.c	2004-03-15 18:22:23.000000000 +0000
@@ -203,8 +203,8 @@
 			return res;
 		dev++;
 		return 0;
-        }
-        return -ENODEV;
+	}
+	return -ENODEV;
 }
 
 static void __devexit snd_es968_pnp_remove(struct pnp_card_link * pcard)
--- linux-2.6.4/sound/isa/dt019x.c~	2004-03-15 18:44:03.000000000 +0000
+++ linux-2.6.4/sound/isa/dt019x.c	2004-03-15 18:44:24.000000000 +0000
@@ -296,8 +296,8 @@
 			return res;
 		dev++;
 		return 0;
-        }
-        return -ENODEV;
+	}
+	return -ENODEV;
 }
 
 static void __devexit snd_dt019x_pnp_remove(struct pnp_card_link * pcard)


