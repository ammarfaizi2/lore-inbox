Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267343AbSKPT1i>; Sat, 16 Nov 2002 14:27:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267344AbSKPT1i>; Sat, 16 Nov 2002 14:27:38 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:248 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S267343AbSKPT1h>; Sat, 16 Nov 2002 14:27:37 -0500
Date: Sat, 16 Nov 2002 20:34:29 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Andi Kleen <ak@muc.de>, Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: [2.4 patch] CONFIG_AGP_AMD_8151 Configure.help entry
Message-ID: <20021116193429.GD28356@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below against 2.4.20-rc2 adds a Configure.help entry for the
new CONFIG_AGP_AMD_8151 option.

cu
Adrian


--- linux-2.4.19/Documentation/Configure.help.old	2002-11-16 20:24:33.000000000 +0100
+++ linux-2.4.19/Documentation/Configure.help	2002-11-16 20:28:39.000000000 +0100
@@ -3543,6 +3543,13 @@
   You should say Y here if you use XFree86 3.3.6 or 4.x and want to
   use GLX or DRI.  If unsure, say N.
 
+CONFIG_AGP_AMD_8151
+  This option gives you AGP support for the GLX component of
+  XFree86 on AMD K8 with an AGP 8151 chipset.
+
+  You should say Y here if you use XFree86 3.3.6 or 4.x and want to
+  use GLX or DRI.  If unsure, say N.
+
 Generic SiS support
 CONFIG_AGP_SIS
   This option gives you AGP support for the GLX component of the "soon
