Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263244AbTIVRNM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 13:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263247AbTIVRNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 13:13:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:46466 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263244AbTIVRNJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 13:13:09 -0400
Date: Mon, 22 Sep 2003 10:06:04 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: rking <rmk@arm.linux.org.uk>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] docs need serial_core file name change
Message-Id: <20030922100604.681da5a7.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Is serial/serial_core.c remaining as the file name?
If so, patch is needed in Docs.

--
~Randy


patch_name:	serial_docs.patch
patch_version:	2003-09-22.10:14:49
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	fix docs for change in source file name;
product:	Linux
product_versions: 2.6.0-922
maintainer:	Russell King
diffstat:	=
 Documentation/DocBook/kernel-api.tmpl |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -Naurp ./Documentation/DocBook/kernel-api.tmpl~serdocs ./Documentation/DocBook/kernel-api.tmpl
--- ./Documentation/DocBook/kernel-api.tmpl~serdocs	2003-09-22 08:45:07.000000000 -0700
+++ ./Documentation/DocBook/kernel-api.tmpl	2003-09-22 10:00:26.000000000 -0700
@@ -234,7 +234,7 @@ X!Isound/sound_firmware.c
 
   <chapter id="uart16x50">
      <title>16x50 UART Driver</title>
-!Edrivers/serial/core.c
+!Edrivers/serial/serial_core.c
 !Edrivers/serial/8250.c
   </chapter>
 
