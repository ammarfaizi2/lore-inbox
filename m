Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316542AbSE3KPL>; Thu, 30 May 2002 06:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316544AbSE3KPK>; Thu, 30 May 2002 06:15:10 -0400
Received: from pop.gmx.net ([213.165.64.20]:63978 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S316542AbSE3KPJ> convert rfc822-to-8bit;
	Thu, 30 May 2002 06:15:09 -0400
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <m.c.p@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] 2.2.21-2-secure
Date: Thu, 30 May 2002 12:13:59 +0200
X-Mailer: KMail [version 1.4]
Organization: WOLK - Working Overloaded Linux Kernel
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200205301148.02949.mcp@linux-systeme.de>
Cc: wolk-announce@lists.sourceforge.net, wolk-devel@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Just another release for the 2.2 kernel tree.
Many people still uses 2.2 and also wants it
instead 2.4 tree for some good reasons.

So i've decided to make also a 2.2 Patchset.
It is not so big like wolk, but nice.

--------------------------------------------------
This is the 2nd release of the 2.2.21-secure tree.
--------------------------------------------------

Downloadable also at http://sf.net/projects/wolk

- Based on 2.2.21 Final

2.2.21-2 includes the following Patches:
----------------------------------------
o OpenWall 1 for 2.2.21
o HAP 1 for OpenWall 1 for 2.2.21
o Stealth Networking
o RAID v2.2.20-raid 4
    - Autodetect
    - Boot support (linear, striped)
o Ext3 Filesystem Support v0.07a
o IFF Dynamic Patch
o PPPoE
o CryptoAPI (Kerneli) 2.2.18-3
o CIPE (Crypto IP Encapsulation)
o Extended Attributes and ACL Support for ext2
    - EA v0.8.26
    - ACL v0.8.27
o Some NIC Driver adds:
    - COMPEX-RL100a / Winbond-W89c840 PCI Ethernet
    - Myson MTD803 PCI Ethernet
    - National Semiconductor DP8381x series PCI Ethernet
    - National Semiconductor DP8382x series PCI Ethernet
    - Sundance ST201 "Alta" PCI Ethernet
o Adaptec AIC7xxx v6.2.4 Driver
o Most Patches of the AA-Kernel v2.2.21pre2aa2 tree
o MPPE v0.9.5
    ppp_mppe is a module to support Microsoft
    Point to Point Encryption in pppd. Mainly for
    use in conjunction with pptpd to allow windows
    machines to setup "secure" VPN's. :)
o BIGMEM (highmem) to allocate Memory >1GB
o USAGI v20020513-2.2.20
o BadRAM / BadMEM v2.2.19B
o FreeS/WAN v1.97
o IDE Backport from 2.4.x (IDE-Ole) v2.2.21.05202002
o IP Virtual Server v1.08 for 2.2 Kernels
o Tekram DC395 SCSI Controller Driver v1.40


Changes in 2.2.21-2
-------------------
o   add:        IDE Backport from 2.4.x (IDE-Ole) v2.2.21.05202002
o   add:        IP Virtual Server v1.08 for 2.2 Kernels
o   add:        Tekram DC395 SCSI Controller Driver v1.40
o   update:     OpenWall and HAP to its newest Version
o   removed:    New IDE from Andre Hedrick in favor of IDE-Ole
o   removed:    ReiserFS Code


Todo for the next releases:
---------------------------
o   Nothing yet :-)


Want to see a patch included to this tree? Let me know!

-- 
Kind regards
        Marc-Christian Petersen

http://sourceforge.net/projects/wolk

PGP/GnuPG Key: 1024D/569DE2E3DB441A16
Fingerprint: 3469 0CF8 CA7E 0042 7824  080A 569D E2E3 DB44 1A16
Key available at wwwkeys.pgp.net.   Encrypted e-mail preferred.


