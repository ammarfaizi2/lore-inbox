Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbUAOT7s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 14:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262652AbUAOT7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 14:59:47 -0500
Received: from serenity.mcc.ac.uk ([130.88.200.93]:35593 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP id S262598AbUAOT7l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 14:59:41 -0500
Date: Thu, 15 Jan 2004 19:59:38 +0000
From: John Levon <levon@movementarian.org>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org
Subject: [PATCH] update OProfile maintainer
Message-ID: <20040115195938.GB35993@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: King of Woolworths - L'Illustration Musicale
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1AhDeU-000HWn-Kz*/En4FIxRGyk*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please apply the below and accept patches directly from Philippe for
OProfile in the future, as necessary.

(Philippe is the other main developer of OProfile)

thanks
john

Index: linux-cvs/MAINTAINERS
===================================================================
RCS file: /home/moz/cvs/linux-2.5/MAINTAINERS,v
retrieving revision 1.221
diff -u -a -p -r1.221 MAINTAINERS
--- linux-cvs/MAINTAINERS	31 Dec 2003 00:59:37 -0000	1.221
+++ linux-cvs/MAINTAINERS	15 Jan 2004 20:37:59 -0000
@@ -1482,8 +1482,8 @@
 S:	Maintained
 
 OPROFILE
-P:	John Levon
-M:	levon@movementarian.org
+P:	Philippe Elie
+M:	phil.el@wanadoo.fr
 L:	oprofile-list@lists.sf.net
 S:	Maintained
 
