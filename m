Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261743AbTCGUGq>; Fri, 7 Mar 2003 15:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261744AbTCGUGq>; Fri, 7 Mar 2003 15:06:46 -0500
Received: from 213-156-58-135.fastres.net ([213.156.58.135]:48000 "EHLO
	galileo.homenet.lan") by vger.kernel.org with ESMTP
	id <S261743AbTCGUGp>; Fri, 7 Mar 2003 15:06:45 -0500
Subject: acx100_pci.o GPL but only binary version
From: alx <alx@autistici.org>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 07 Mar 2003 21:17:20 +0100
Message-Id: <1047068240.1604.11.camel@galileo.homenet.lan>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI all
I got this module from the net (binary version)

acx100_pci.o wanna be a linux driver from the TI acx100 chipset.
but it doesn't work at all!
- First ifconfig SegFault 
- Second hangs the machine

I did modinfo on this module and I got:

 $ modinfo acx100_pci.o
filename:    acx100_pci.o
description: "TI ACX100 WLAN 22Mbps driver"
author:      "Lancelot Wang"
license:     "GPL"
 $

Someone has the source code or know the author ?



