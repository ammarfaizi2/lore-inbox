Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261741AbREPBYZ>; Tue, 15 May 2001 21:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261755AbREPBYP>; Tue, 15 May 2001 21:24:15 -0400
Received: from viper.haque.net ([66.88.179.82]:24223 "EHLO mail.haque.net")
	by vger.kernel.org with ESMTP id <S261741AbREPBYN>;
	Tue, 15 May 2001 21:24:13 -0400
Message-ID: <3B01D6BC.7714E184@haque.net>
Date: Tue, 15 May 2001 21:24:12 -0400
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] ymfpci.h add PCIR_DSXPWRCTRL1 && PCIR_DSXPWRCTRL2
Content-Type: multipart/mixed;
 boundary="------------4D7F02D5D528BA08944DB901"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------4D7F02D5D528BA08944DB901
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

This part of the whole ymfpci change is missing....

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/ 
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================
--------------4D7F02D5D528BA08944DB901
Content-Type: text/plain; charset=us-ascii;
 name="ymfpci.h.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ymfpci.h.diff"

--- linux/drivers/sound/ymfpci.h.orig	Tue May 15 21:15:54 2001
+++ linux/drivers/sound/ymfpci.h	Tue May 15 21:17:30 2001
@@ -135,6 +135,8 @@
 #define PCIR_LEGCTRL			0x40
 #define PCIR_ELEGCTRL			0x42
 #define PCIR_DSXGCTRL			0x48
+#define PCIR_DSXPWRCTRL1	0x4a
+#define PCIR_DSXPWRCTRL2	0x4e
 #define PCIR_OPLADR			0x60
 #define PCIR_SBADR			0x62
 #define PCIR_MPUADR			0x64

--------------4D7F02D5D528BA08944DB901--

