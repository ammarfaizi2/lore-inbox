Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274975AbTHLBqr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 21:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274976AbTHLBqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 21:46:47 -0400
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:57485 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S274975AbTHLBqo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 21:46:44 -0400
Date: Tue, 12 Aug 2003 03:46:40 +0200
From: Manuel Estrada Sainz <ranty@debian.org>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] state request_firmware() maintainership.
Message-ID: <20030812014640.GA31498@ranty.pantax.net>
Reply-To: ranty@debian.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 I am not sure to hom I should should send this one, so I figured you
 where a good victim :)

 ChangeLog:
	
	 Add myself to MAINTAINERS for request_firmware().
	


 MAINTAINERS |    6 ++++++
 1 files changed, 6 insertions(+)


diff --exclude=CVS -urN linux-2.5.orig/MAINTAINERS linux-2.5.mine/MAINTAINERS
--- linux-2.5.orig/MAINTAINERS	2003-08-12 03:34:05.000000000 +0200
+++ linux-2.5.mine/MAINTAINERS	2003-08-11 00:52:07.000000000 +0200
@@ -717,6 +717,12 @@
 M:	viro@math.psu.edu
 S:	Maintained
 
+FIRMWARE LOADER (request_firmware)
+P:	Manuel Estrada Sainz
+M:	ranty@debian.org
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+
 FPU EMULATOR
 P:	Bill Metzenthen
 M:	billm@suburbia.net

-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.
