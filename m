Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287344AbSAZXmE>; Sat, 26 Jan 2002 18:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287373AbSAZXlp>; Sat, 26 Jan 2002 18:41:45 -0500
Received: from dsl092-237-176.phl1.dsl.speakeasy.net ([66.92.237.176]:38154
	"EHLO whisper.qrpff.net") by vger.kernel.org with ESMTP
	id <S287344AbSAZXlm>; Sat, 26 Jan 2002 18:41:42 -0500
Message-Id: <5.1.0.14.2.20020126183314.01cbb510@whisper.qrpff.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sat, 26 Jan 2002 18:37:26 -0500
To: linux-kernel@vger.kernel.org
From: Stevie O <stevie@qrpff.net>
Subject: 2.2.20: pci-scan+natsemi & Device or resource busy
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My friend is trying Linux for the first time. I'm having him use the 
pci-scan and natsemi modules for his Netgear FA-311 card. With the initial 
download and compile and insmod, he got that wonderful message:

natsemi.o: init_module: Device or resource busy

He was using 2.2.13, so I got him to upgrade to 2.2.20 to see if that might 
have fixed some problem. However, the problem still hasn't gone away :(
No amount of googling has revealed a solution to the problem, since which 
I've discovered that "Device or resource busy" is an extremely vague error 
message.

Please help!


--
Stevie-O

Real programmers use COPY CON PROGRAM.EXE

