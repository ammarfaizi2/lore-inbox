Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262804AbSJ1B2f>; Sun, 27 Oct 2002 20:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262805AbSJ1B2f>; Sun, 27 Oct 2002 20:28:35 -0500
Received: from pacific.moreton.com.au ([203.143.238.4]:9442 "EHLO
	dorfl.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id <S262804AbSJ1B2e>; Sun, 27 Oct 2002 20:28:34 -0500
Message-ID: <3DBC949D.4030208@snapgear.com>
Date: Mon, 28 Oct 2002 11:36:29 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH]: linux-2.5.44uc2 (MMU-less support)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi All,

The latest set of MMU-less support patches are up. You can
get the all-in-one patch at:

http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.44uc2.patch.gz

Change log:
1. made system call table common for all m68knommu arch  (me)
2. arch Makefile fixups                                  (Sam Ravnborg)


You can get smaller patches here:

. FEC (5272) ethernet driver
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.44uc2-fec.patch.gz

. 68k/ColdFire/v850 serial drivers
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.44uc2-serial.patch.gz

. 68328 frame buffer driver
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.44uc2-fb.patch.gz

. FLAT file loader
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.44uc2-binflat.patch.gz

. m68knommu architecture support
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.44uc2-m68knommu.patch.gz

. v850 architecture support
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.44uc2-v850.patch.gz

. no VM memory support
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.44uc2-mmnommu.patch.gz

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
SnapGear Pty Ltd                               PHONE:    +61 7 3435 2888
825 Stanley St,                                  FAX:    +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com



