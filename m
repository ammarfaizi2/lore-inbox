Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbWIUEER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWIUEER (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 00:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbWIUEEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 00:04:16 -0400
Received: from de01egw02.freescale.net ([192.88.165.103]:29382 "EHLO
	de01egw02.freescale.net") by vger.kernel.org with ESMTP
	id S1751193AbWIUEEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 00:04:15 -0400
Subject: [patch 0/3 v2] Add tsi108 On chip Ethernet device driver support
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: jgarzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       netdev <netdev@vger.kernel.org>
In-Reply-To: <1158051315.14448.91.camel@localhost.localdomain>
References: <A0CDBA58F226D911B202000BDBAD46730A1B1410@zch01exm23.fsl.freescale.net>
	 <1157962200.10526.10.camel@localhost.localdomain>
	 <1158051315.14448.91.camel@localhost.localdomain>
Content-Type: text/plain
Organization: 
Message-Id: <1158811443.10823.40.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 21 Sep 2006 12:04:03 +0800
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Sep 2006 04:04:10.0010 (UTC) FILETIME=[FDA39FA0:01C6DD32]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Tundra Semiconductor Corporation (Tundra) Tsi108/9 is a host bridge
for PowerPC processors that offers numerous system interconnect options
for embedded application designers . The Tsi108/9 can interconnect 60x
or MPX processors to PCI/X peripherals, DDR2-400 memory, Gigabit
Ethernet, and Flash.

Tsi108/109 is used on powerpc/mpc7448hpc2 platform.

The following serial patches provide Tsi108/9 on chip Ethernet chip
support.

1/3 : Config and Makefile modification.
2/3 : Header file
3/3 : C body file

This serial patches fix the issues in the feedback from the previous
patches.
Feedback is welcomed.
Roy 

