Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267102AbTAVAkP>; Tue, 21 Jan 2003 19:40:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267112AbTAVAkP>; Tue, 21 Jan 2003 19:40:15 -0500
Received: from pacific.moreton.com.au ([203.143.238.4]:13829 "EHLO
	dorfl.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id <S267102AbTAVAkO>; Tue, 21 Jan 2003 19:40:14 -0500
Message-ID: <3E2DEA44.3040207@snapgear.com>
Date: Wed, 22 Jan 2003 10:48:04 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH]: linux-2.5.59-uc0 (MMU-less fix ups)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

An update of the uClinux (MMU-less) fixups against 2.5.59.
Linus commited a bunch of patches so this is a whole lot
smaller again. The new common RODATA is causing me some
problems, so what is in this patch is a temporary fix only.

http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.59-uc0.patch.gz


Also updated:

. Motorola 68328 framebuffer driver
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.59-uc0-68328fb.patch.gz

. Hitachi H8300 achitecture support
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.59-uc0-h8300.patch.gz

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
Snapgear Pty Ltd                               PHONE:    +61 7 3279 1822
825 Stanley St,                                  FAX:    +61 7 3279 1820
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com




