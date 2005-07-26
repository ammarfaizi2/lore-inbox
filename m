Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261886AbVGZTwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261886AbVGZTwY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 15:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261915AbVGZTwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 15:52:24 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:55714 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S261886AbVGZTuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 15:50:04 -0400
Date: Tue, 26 Jul 2005 12:49:53 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Dan Malek <dan@embeddededge.com>
Subject: [PATCH 2.6.13-rc3] Change PowerPC MPC8xx maintainer
Message-ID: <20050726194953.GB8817@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As Marcelo has been spending a great deal of time working on MPC8xx
systems of late (thanks!) and has more time than I do now for it, I'm
handing this over to him.

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

diff --git a/MAINTAINERS b/MAINTAINERS
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1416,13 +1416,20 @@ W:	http://www.penguinppc.org/
 L:	linuxppc-embedded@ozlabs.org
 S:	Maintained
 
-LINUX FOR POWERPC EMBEDDED PPC8XX AND BOOT CODE
+LINUX FOR POWERPC BOOT CODE
 P:	Tom Rini
 M:	trini@kernel.crashing.org
 W:	http://www.penguinppc.org/
 L:	linuxppc-embedded@ozlabs.org
 S:	Maintained
 
+LINUX FOR POWERPC EMBEDDED PPC8XX
+P:	Marcelo Tosatti
+M:	marcelo.tosatti@cyclades.com
+W:	http://www.penguinppc.org/
+L:	linuxppc-embedded@ozlabs.org
+S:	Maintained
+
 LINUX FOR POWERPC EMBEDDED PPC83XX AND PPC85XX
 P:     Kumar Gala
 M:     kumar.gala@freescale.com

-- 
Tom Rini
http://gate.crashing.org/~trini/
