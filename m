Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261561AbSJCPQj>; Thu, 3 Oct 2002 11:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261443AbSJCPQd>; Thu, 3 Oct 2002 11:16:33 -0400
Received: from mta06bw.bigpond.com ([139.134.6.96]:18137 "EHLO
	mta06bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S261447AbSJCPPv>; Thu, 3 Oct 2002 11:15:51 -0400
Message-ID: <3D9C6101.4010205@snapgear.com>
Date: Fri, 04 Oct 2002 01:23:45 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH]: linux-2.5.40uc1 (MMU-less support)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

An updated uClinux patch is available at:

http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.40uc1.patch.gz

Changelog:

1. minor v850 fixes
2. clean up of kernel/ksyms.c (now no diffs)
3. clean up of fs/proc/* (still some diffs)


Smaller patches:

. FEC ColdFire 5272 ethernet driver
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.40uc1-fec.patch.gz

. m68k/ColdFire/v850 serial drivers
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.40uc1-serial.patch.gz

. 68328 frame buffer
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.40uc1-fb.patch.gz

. binfmt_flat loader
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.40uc1-binflat.patch.gz

. m68knommu architecture
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.40uc1-m68knommu.patch.gz

. v850 architecture
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.40uc1-v850.patch.gz

. mmnommu (MMU-less) only patch
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.40uc1-mmnommu.patch.gz

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
Snapgear Pty Ltd                               PHONE:    +61 7 3279 1822
825 Stanley St,                                  FAX:    +61 7 3279 1820
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com

