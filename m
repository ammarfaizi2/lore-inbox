Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290765AbSAYSRv>; Fri, 25 Jan 2002 13:17:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290785AbSAYSRl>; Fri, 25 Jan 2002 13:17:41 -0500
Received: from f4.law7.hotmail.com ([216.33.237.4]:44562 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S290769AbSAYSR0>;
	Fri, 25 Jan 2002 13:17:26 -0500
X-Originating-IP: [128.8.126.4]
From: "chus Medina" <chuslists@hotmail.com>
To: linux-kernel@vger.kernel.org
Cc: chus@glue.umd.edu
Subject: PCI #LOCK assertion
Date: Fri, 25 Jan 2002 18:17:20 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F4T0giSftNtzsG06vdG0001152a@hotmail.com>
X-OriginalArrivalTime: 25 Jan 2002 18:17:20.0596 (UTC) FILETIME=[875C2940:01C1A5CC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hola,

I need to create module to perform atomic transactions through the PCI bus 
between the processor and an IDE hard disk. The PCI bus specifications 2.2 
point to the #LOCK signal to perform such a transaction. Is possible to 
assert the #LOCK signal of the PCI bus using the Linux Kernel? How? I didnt 
see any pointers in include/pci.h or anywhere in the source code.

I will truly appreciate any help/pointers,

Jesus



_________________________________________________________________
Send and receive Hotmail on your mobile device: http://mobile.msn.com

