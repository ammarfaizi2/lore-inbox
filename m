Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265255AbSKFN4b>; Wed, 6 Nov 2002 08:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265279AbSKFN4b>; Wed, 6 Nov 2002 08:56:31 -0500
Received: from mta06bw.bigpond.com ([139.134.6.96]:38639 "EHLO
	mta06bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S265255AbSKFN4a>; Wed, 6 Nov 2002 08:56:30 -0500
Message-ID: <3DC92170.4030400@snapgear.com>
Date: Thu, 07 Nov 2002 00:04:32 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH]: linux-2.5.46-uc1 (MMU-less fix ups)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

A few more minor fixups applied to this patch set.

http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.46-uc1.patch.gz

Changelog:

1. 2.5.46 v850 fixups            (Miles Bader)
2. m68knommu entry.S clean up    (me)
3. flat.h intro comment          (David McCullough)


Smaller specific patches:

. FEC ColdFire 5272 feature add patch
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.46-uc1-fec.patch.gz

. m68k/ColdFire/v850 serial drivers
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.46-uc1-serial.patch.gz

. 68328 frame buffer
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.46-uc1-fb.patch.gz

. binfmt_flat patch
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.46-uc1-binflat.patch.gz

. m68knommu architecture fixups for 2.5.46
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.46-uc1-m68knommu.patch.gz

. v850 architecture fixups for 2.5.46
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.46-uc1-v850.patch.gz

. add missing MMU-less support patches
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.46-uc1-mm.patch.gz

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
Snapgear Pty Ltd                               PHONE:    +61 7 3279 1822
825 Stanley St,                                  FAX:    +61 7 3279 1820
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com










