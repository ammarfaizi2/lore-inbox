Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262128AbUBIVWp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 16:22:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262687AbUBIVWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 16:22:45 -0500
Received: from smtp-101-monday.nerim.net ([62.4.16.101]:11016 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S262128AbUBIVWn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 16:22:43 -0500
Date: Mon, 9 Feb 2004 22:23:18 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4] i2c maintainer entry
Message-Id: <20040209222318.57d2891d.khali@linux-fr.org>
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,

Here is a trivial patch that updates the I2C entry within the
MAINTAINERS file. There are no sensors drivers in the 2.4 kernel, and I
think that "subsystem" is a more appropriate term.

Please apply,
thanks.


--- linux-2.4.25-rc1/MAINTAINERS.orig	Mon Feb  9 22:09:17 2004
+++ linux-2.4.25-rc1/MAINTAINERS	Mon Feb  9 22:14:34 2004
@@ -823,7 +823,7 @@
 W:	http://artax.karlin.mff.cuni.cz/~mikulas/vyplody/hpfs/index-e.cgi
 S:	Maintained
 
-I2C AND SENSORS DRIVERS
+I2C SUBSYSTEM
 P:	Jean Delvare
 M:	khali@linux-fr.org
 L:	sensors@stimpy.netroedge.com

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
