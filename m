Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317698AbSHCULB>; Sat, 3 Aug 2002 16:11:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317701AbSHCULA>; Sat, 3 Aug 2002 16:11:00 -0400
Received: from medelec.uia.ac.be ([143.169.17.1]:48651 "EHLO medelec.uia.ac.be")
	by vger.kernel.org with ESMTP id <S317698AbSHCULA>;
	Sat, 3 Aug 2002 16:11:00 -0400
Date: Sat, 3 Aug 2002 22:14:25 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: i8xx series patches for 2.5.30
Message-ID: <20020803221425.A18344@medelec.uia.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I just sent you 6 bitkeeper patches for the i8xx series chipsets.
The patches are:
1) ftp://medelec.uia.ac.be/pub/linux/kernel-patches/i8xx-patch-against-2.5.30-patch-1.txt
This patch contains pci.ids updates for the i8xx chipsets

2) ftp://medelec.uia.ac.be/pub/linux/kernel-patches/i8xx-patch-against-2.5.30-patch-2.txt
This patch makes the i810_rng Documentation the same as it is in 2.4.19

3) ftp://medelec.uia.ac.be/pub/linux/kernel-patches/i8xx-patch-against-2.5.30-patch-3.txt
This patch adds a set of defines to pci_ids.h for 82801E and 82801DB I/O Controller Hub PCI-IDS.
I could not add them all since two of them existed allready for the IDE controllers, but the naming was not ideal. That's why patch 5 and 6 corrects this.

4) ftp://medelec.uia.ac.be/pub/linux/kernel-patches/i8xx-patch-against-2.5.30-patch-4.txt
This patch updates the i810-tco module to the same level as it is in 2.4.19 now.

5) ftp://medelec.uia.ac.be/pub/linux/kernel-patches/i8xx-patch-against-2.5.30-patch-5.txt
This patch corrects the PCI-ID define for the 82801DB IDE controller.

6) ftp://medelec.uia.ac.be/pub/linux/kernel-patches/i8xx-patch-against-2.5.30-patch-6.txt
This patch corrects the PCI-ID define for the 82801E IDE controller.

Greetings,
Wim.

