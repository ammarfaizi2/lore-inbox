Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266217AbTGDWzG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 18:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266220AbTGDWzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 18:55:05 -0400
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:29456 "EHLO
	young-lust.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id S266217AbTGDWy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 18:54:29 -0400
To: torvalds@osdl.org, akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5] [3/6] EISA support updates
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
References: <wrpk7axvqv1.fsf@hina.wild-wind.fr.eu.org>
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: Sat, 05 Jul 2003 01:06:02 +0200
Message-ID: <wrp3chlvqn9.fsf@hina.wild-wind.fr.eu.org>
In-Reply-To: <wrpk7axvqv1.fsf@hina.wild-wind.fr.eu.org> (Marc Zyngier's
 message of "Sat, 05 Jul 2003 01:01:22 +0200")
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

More EISA ids.

     M.

diff -ruN linux-latest/drivers/eisa/eisa.ids linux-eisa/drivers/eisa/eisa.ids
--- linux-latest/drivers/eisa/eisa.ids	2003-07-04 09:38:32.000000000 +0200
+++ linux-eisa/drivers/eisa/eisa.ids	2003-07-04 09:39:32.000000000 +0200
@@ -504,6 +504,7 @@
 DTK0003 "DTK PLM-3331P EISACACHE486 33/25/50 MHZ"
 ECS0580 "DI-580A EISA SCSI Host Adapter"
 ECS0590 "DI-590 EISA SCSI Cache Host Adapter"
+EGL0101 "Eagle Technology EP3210 EtherXpert EISA Adapter"
 ELS8041 "ELSA  WINNER 1000  Enhanced VGA"
 ETI1001 "NE3300 Ethernet Rev. C & D"
 EVX0002 "PN-3000 System Board"
@@ -515,6 +516,9 @@
 FSI2001 "ESA-200 ATM"
 FSI2002 "ESA-200A ATM"
 FSI2003 "ESA-200E ATM"
+GCI0101 "Gateway G/Ethernet 32EB -- 32-Bit EISA Bus Master Ethernet Adpater"
+GCI0102 "Gateway G/Ethernet 32EB -- 32-Bit EISA Bus Master Ethernet Adapter"
+GCI0103 "Gateway G/Ethernet 32EB -- 32-Bit EISA Bus Master Ethernet Adapter"
 GDT2001 "GDT2000/GDT2020 Fast-SCSI Cache Controller - Rev. 1.0"
 GDT3001 "GDT3000/GDT3020 Dual Channel SCSI Controller - Rev. 1.0"
 GDT3002 "GDT30x0A Cache Controller"
@@ -1138,12 +1142,14 @@
 NON0601 "c't Universal 8-Bit Adapter"
 NSS0011 "Newport Systems Solutions WNIC Adapter"
 NVL0701 "Novell NE3200 Bus Master Ethernet"
+NVL0702 "Novell NE3200T Bus Master Ethernet"
 NVL0901 "Novell NE2100 Ethernet/Cheapernet Adapter"
 NVL1001 "Novell NMSL (Netware Mirrored Server Link)"
 NVL1201 "Novell NE32HUB 32-bit Base EISA Adapter"
 NVL1301 "Novell NE32HUB 32-bit TPE EISA Adapter"
 NVL1401 "Novell NE32HUB PME ISA Adapter"
 NVL1501 "Novell NE2000PLUS Ethernet Adapter"
+NVL1801 "Eagle Technology NE3210 EISA Ethernet LAN Adapter"
 OLC0701 "Olicom ISA 16/4 Token-Ring Network Adapter"
 OLC0702 "Olicom OC-3117, ISA 16/4 Adapter (NIC)"
 OLC0801 "OC-3118 Olicom ISA 16/4 Token-Ring Network Adapter"

-- 
Places change, faces change. Life is so very strange.
