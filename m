Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315275AbSHRPk2>; Sun, 18 Aug 2002 11:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315267AbSHRPk2>; Sun, 18 Aug 2002 11:40:28 -0400
Received: from [213.23.6.193] ([213.23.6.193]:36367 "HELO is1.blocksberg.com")
	by vger.kernel.org with SMTP id <S315266AbSHRPk1> convert rfc822-to-8bit;
	Sun, 18 Aug 2002 11:40:27 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Justin Heesemann <jh@ionium.org>
Organization: ionium Technologies
To: linux-kernel@vger.kernel.org
Subject: epox 4g4a+ (i845g and hpt372) with kernel 2.4.x: Ok, now booting the kernel. hangs.
Date: Sun, 18 Aug 2002 17:46:30 +0200
User-Agent: KMail/1.4.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200208181746.30967.jh@ionium.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I've got some problems with booting a 2.4.19 (and other 2.4 kernels).
The system is a P4 2.0 Ghz Northwood, Epox 4G4A+ (i845g) with onboard HPT372 
and Realtek LAN, 512 MB DDR Ram, 80 GB Seagate IDE Disk at IDE1 and a CDROM 
at IDE2. I am not using the HPT IDE Ports at this time (also tried with 
disabling the HPT in the BIOS.

Ok. Whenever i try to boot a 2.4 Kernel (i tried the ones provided by the 
Debian 3.0 boot cd, Knoppix boot cd and a p4 optimized gentoo kernel) It gets 
as far as:

Loading kernel..................
Loading 
rescue.gz.......................................................................
ready.
Uncompressing Linux... Ok, now booting the kernel.

Then it hangs.
Is there a way to get more information what exactly it is doing before it 
hangs ?

-- 
Best Regards,
Justin Heesemann
