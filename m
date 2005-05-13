Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262584AbVEMW1W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262584AbVEMW1W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 18:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262577AbVEMWKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 18:10:30 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:60832 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262568AbVEMWKA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 18:10:00 -0400
Message-Id: <20050513220225.382452000@abc>
References: <20050513220019.907667000@abc>
Date: Sat, 14 May 2005 00:00:23 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Patrick Boettcher <pb@linuxtv.org>
Content-Disposition: inline; filename=dvb-flexcop-readme.patch
X-SA-Exim-Connect-IP: 217.231.56.126
Subject: [DVB patch 04/11] flexcop: add acknowledgements
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

add acknowledgements

Signed-off-by: Patrick Boettcher <pb@linuxtv.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>
---

 Documentation/dvb/README.flexcop |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletion(-)

Index: linux-2.6.12-rc4/Documentation/dvb/README.flexcop
===================================================================
--- linux-2.6.12-rc4.orig/Documentation/dvb/README.flexcop	2005-05-12 01:30:04.000000000 +0200
+++ linux-2.6.12-rc4/Documentation/dvb/README.flexcop	2005-05-12 01:30:22.000000000 +0200
@@ -274,6 +274,11 @@ Acknowledgements (just for the rewriting
 Bjarne Steinsbo thought a lot in the first place of the pci part for this code
 sharing idea.
 
-Andreas Oberritter for providing a recent PCI initialization template (pluto2.c).
+Andreas Oberritter for providing a recent PCI initialization template
+(pluto2.c).
+
+Boleslaw Ciesielski for pointing out a problem with firmware loader.
+
+Vadim Catana for correcting the USB transfer.
 
 comments, critics and ideas to linux-dvb@linuxtv.org or patrick.boettcher@desy.de

--

