Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266408AbTAOCHQ>; Tue, 14 Jan 2003 21:07:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266411AbTAOCHQ>; Tue, 14 Jan 2003 21:07:16 -0500
Received: from pacific.moreton.com.au ([203.143.238.4]:16393 "EHLO
	dorfl.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id <S266408AbTAOCHP>; Tue, 14 Jan 2003 21:07:15 -0500
Message-ID: <3E24C45A.8080705@snapgear.com>
Date: Wed, 15 Jan 2003 12:15:54 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH]: linux-2.5.58-uc0 (MMU-less fix ups)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

An update of the uClinux (MMU-less) fixups against 2.5.58.
Linus commited a bunch of patches so this is a whole lot
smaller now. I still want to rework the sub-architecture
config.c files in this, so this patch set is still a work
in progress.

http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.58-uc0.patch.gz


Also updated:

. Motorola 68328 framebuffer driver
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.58-uc0-68328fb.patch.gz

. Hitachi H8300 achitecture support
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.58-uc0-h8300.patch.gz

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
Snapgear Pty Ltd                               PHONE:    +61 7 3279 1822
825 Stanley St,                                  FAX:    +61 7 3279 1820
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com



