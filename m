Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbTJMWE5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 18:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbTJMWE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 18:04:57 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:33287 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP id S261988AbTJMWE4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 18:04:56 -0400
Date: Mon, 13 Oct 2003 23:04:54 +0100
From: John Levon <levon@movementarian.org>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: [PATCH] fix config help typo for nfs-tcp
Message-ID: <20031013220454.GA15166@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: King of Woolworths - L'Illustration Musicale
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1A9AoB-0007FE-5d*uznMBDUHH/s*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


regards
john

Index: linux-cvs/fs/Kconfig
===================================================================
RCS file: /home/cvs/linux-2.5/fs/Kconfig,v
retrieving revision 1.34
diff -u -a -p -r1.34 Kconfig
--- linux-cvs/fs/Kconfig	9 Oct 2003 01:51:51 -0000	1.34
+++ linux-cvs/fs/Kconfig	13 Oct 2003 21:57:51 -0000
@@ -1381,7 +1381,7 @@ config NFSD_TCP
 	bool "Provide NFS server over TCP support (EXPERIMENTAL)"
 	depends on NFSD && EXPERIMENTAL
 	help
-	  Enable NFS service over TCP connections.  This the officially
+	  Enable NFS service over TCP connections.  This is officially
 	  still experimental, but seems to work well.
 
 config ROOT_NFS
