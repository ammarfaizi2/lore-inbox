Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293557AbSBZJ6c>; Tue, 26 Feb 2002 04:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293558AbSBZJ6V>; Tue, 26 Feb 2002 04:58:21 -0500
Received: from sky.irisa.fr ([131.254.60.147]:41123 "EHLO sky.irisa.fr")
	by vger.kernel.org with ESMTP id <S293557AbSBZJ6N>;
	Tue, 26 Feb 2002 04:58:13 -0500
Message-ID: <3C7B5C2E.E58D944F@irisa.fr>
Date: Tue, 26 Feb 2002 10:58:06 +0100
From: Romain Dolbeau <dolbeau@irisa.fr>
Organization: IRISA, Campus de Beaulieu, 35042 Rennes Cedex, FRANCE
X-Mailer: Mozilla 4.78 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: marcelo@conectiva.com.br
CC: linux-kernel@vger.kernel.org
Subject: [PATCH][2.4] maintainers entry for pm3fb
Content-Type: multipart/mixed;
 boundary="------------70FB9B97F331DAF7B1F024B0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------70FB9B97F331DAF7B1F024B0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Sorry, I forgot to put the MAINTAINERS entry in
the pm3fb (Permedia 3 Framebuffer) patch.

Here's a small patch that add it.

-- 
DOLBEAU Romain               |   I have lost the will to live           
ENS Cachan / Ker Lann        |    Simply nothing more to give           
Thesard IRISA / CAPS         |       -- Metallica,                      
dolbeaur@club-internet.fr    |            'Fade to Black'
--------------70FB9B97F331DAF7B1F024B0
Content-Type: text/plain; charset=us-ascii;
 name="patch-maint"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-maint"

--- linux-2.4.19-pre1/MAINTAINERS	Mon Feb 25 20:37:52 2002
+++ linux-2.4.19-pre1-pm3fb/MAINTAINERS	Tue Feb 26 10:43:46 2002
@@ -1224,6 +1224,13 @@
 L:	linux-net@vger.kernel.org
 S:	Maintained
 
+PERMEDIA 3 FRAMEBUFFER DRIVER
+P:	Romain Dolbeau
+M:	dolbeau@irisa.fr
+L:	linux-fbdev-devel@lists.sourceforge.net
+W:	http://www.irisa.fr/prive/dolbeau/pm3fb/pm3fb.html
+S:	Maintained
+
 PNP SUPPORT
 P:	Tom Lees
 M:	tom@lpsg.demon.co.uk

--------------70FB9B97F331DAF7B1F024B0--

