Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266796AbTBYEoj>; Mon, 24 Feb 2003 23:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267043AbTBYEoj>; Mon, 24 Feb 2003 23:44:39 -0500
Received: from pacific.moreton.com.au ([203.143.238.4]:24327 "EHLO
	dorfl.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id <S266796AbTBYEoh>; Mon, 24 Feb 2003 23:44:37 -0500
Message-ID: <3E5AF6BF.2090301@snapgear.com>
Date: Tue, 25 Feb 2003 14:53:19 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH]: linux-2.5.63-uc0 (MMU-less fix ups)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

An update of the uClinux (MMU-less) fixups against 2.5.63.
With Linus' recent merge of m68knommu there is only a small
set of patches remaining. A few small 2.5.62 -> 2.5.63 fixes
and a cleanup of the vector and timer config/setup for
ColdFire CPUs.

http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.63-uc0.patch.gz


Also updated:

. Motorola 68328 framebuffer driver
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.63-uc0-68328fb.patch.gz

. Hitachi H8300 achitecture support
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.63-uc0-h8300.patch.gz

Regards
Greg



------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
Snapgear Pty Ltd                               PHONE:    +61 7 3279 1822
825 Stanley St,                                  FAX:    +61 7 3279 1820
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com






