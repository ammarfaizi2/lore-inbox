Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262425AbTAIJja>; Thu, 9 Jan 2003 04:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262418AbTAIJiY>; Thu, 9 Jan 2003 04:38:24 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:26326 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S262420AbTAIJiI>; Thu, 9 Jan 2003 04:38:08 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH]  Small update to arch/v850/README
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030109094642.BC77F374D@mcspd15.ucom.lsi.nec.co.jp>
Date: Thu,  9 Jan 2003 18:46:42 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruN -X../cludes linux-2.5.55-moo.orig/arch/v850/README linux-2.5.55-moo/arch/v850/README
--- linux-2.5.55-moo.orig/arch/v850/README	2002-11-05 11:25:21.000000000 +0900
+++ linux-2.5.55-moo/arch/v850/README	2003-01-09 14:07:36.000000000 +0900
@@ -1,7 +1,6 @@
 This port to the NEC V850E processor supports the following platforms:
 
-   + The gdb v850e simulator (CONFIG_V850E_SIM); see the subdirectory `sim'
-     for some more support files for this.
+   + The gdb v850e simulator (CONFIG_V850E_SIM).
 
    + The Midas labs RTE-V850E/MA1-CB evaluation board (CONFIG_RTE_CB_MA1),
      with untested support for the RTE-V850E/NB85E-CB board
