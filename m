Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263290AbSJOPTS>; Tue, 15 Oct 2002 11:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263310AbSJOPTS>; Tue, 15 Oct 2002 11:19:18 -0400
Received: from mta06bw.bigpond.com ([139.134.6.96]:61182 "EHLO
	mta06bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S263290AbSJOPTQ>; Tue, 15 Oct 2002 11:19:16 -0400
Message-ID: <3DAC337D.7010804@snapgear.com>
Date: Wed, 16 Oct 2002 01:25:49 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH]: linux-2.5.42uc1 (MMU-less support)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

An updated uClinux patch is available at:

http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.42uc1.patch.gz

Changelog:

1. v850 update
2. cleaned up mm/page_alloc.c


Smaller specific patches:

. FEC ColdFire 5272 ethernet driver
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.42uc1-fec.patch.gz

. m68k/ColdFire/v850 serial drivers
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.42uc1-serial.patch.gz

. 68328 frame buffer
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.42uc1-fb.patch.gz

. binfmt_flat loader
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.42uc1-binflat.patch.gz

. m68knommu architecture
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.42uc1-m68knommu.patch.gz

. v850 architecture
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.42uc1-v850.patch.gz

. mm (MMU-less) only patch
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.42uc1-mm.patch.gz

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
Snapgear Pty Ltd                               PHONE:    +61 7 3279 1822
825 Stanley St,                                  FAX:    +61 7 3279 1820
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com




