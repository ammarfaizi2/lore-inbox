Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316825AbSE3S4S>; Thu, 30 May 2002 14:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316831AbSE3S4R>; Thu, 30 May 2002 14:56:17 -0400
Received: from 217-126-207-69.uc.nombres.ttd.es ([217.126.207.69]:3844 "EHLO
	server01.nullzone.prv") by vger.kernel.org with ESMTP
	id <S316825AbSE3S4R>; Thu, 30 May 2002 14:56:17 -0400
Message-Id: <5.1.0.14.2.20020530205439.02cb50e8@192.168.2.131>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 30 May 2002 20:57:04 +0200
To: linux-kernel@vger.kernel.org
From: system_lists@nullzone.org
Subject: Halt on 2.5.18
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I got next message some hours ago on a kernel 2.5.18

May 30 18:39:10 server01 kernel: hdc: dma_intr: status=0x7f { DriveReady 
DeviceF
ault SeekComplete DataRequest CorrectedError Index Error }
May 30 18:39:10 server01 kernel: hdc: dma_intr: error=0x00 { }

Any guru can tell me what this exactly mean?
I have rebooted (i got the system halted) and all like goes ok.

That harddisk have only the /var 

