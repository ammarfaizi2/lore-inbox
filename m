Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261609AbSKHFD3>; Fri, 8 Nov 2002 00:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261596AbSKHFD3>; Fri, 8 Nov 2002 00:03:29 -0500
Received: from pacific.moreton.com.au ([203.143.238.4]:33791 "EHLO
	dorfl.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id <S261609AbSKHFD2>; Fri, 8 Nov 2002 00:03:28 -0500
Message-ID: <3DCB4780.5040301@snapgear.com>
Date: Fri, 08 Nov 2002 15:11:28 +1000
From: gerg@snapgear.com
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH]: linux-2.5.46-uc2 (MMU-less fixups)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi All,

Big cleanup of all the m68knommu arch linker scripts.
Now all merged into a single file. Al lot better, but
I think it can still be made a little better. More
to come...

http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.46-uc2.patch.gz

Change log:
1. merge all m68knommu linker scripts into one        (me)


You can get smaller patches here:

. FEC (5272) patch
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.46-uc2-fec.patch.gz

. 68k/ColdFire/v850 serial drivers
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.46-uc2-serial.patch.gz

. 68328 frame buffer driver
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.46-uc2-fb.patch.gz

. m68knommu patches
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.46-uc2-m68knommu.patch.gz

. v850 patches
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.46-uc2-v850.patch.gz

. missing no MM peices (some mm/, /kernel and /fs/proc files)
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.46-uc2-mm.patch.gz

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
SnapGear Pty Ltd                               PHONE:    +61 7 3435 2888
825 Stanley St,                                  FAX:    +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com







