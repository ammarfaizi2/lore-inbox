Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267025AbSKWNRC>; Sat, 23 Nov 2002 08:17:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267026AbSKWNRC>; Sat, 23 Nov 2002 08:17:02 -0500
Received: from mta03ps.bigpond.com ([144.135.25.135]:50901 "EHLO
	mta03ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S267025AbSKWNRB>; Sat, 23 Nov 2002 08:17:01 -0500
Message-ID: <3DDF81F5.5050809@snapgear.com>
Date: Sat, 23 Nov 2002 23:26:13 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH]: linux-2.5.49-uc0 (MMU-less fix ups)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

An update of the uClinux (MMU-less) fixups against 2.5.49.
Nothing much new, this is just keeping the fixes up to date.

http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.49-uc0.patch.gz

Changelog:

1. patch against 2.5.49              (me)
2. v850 additions                    (Miles Bader)

Also updated:

. Motorola 68328 framebuffer driver
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.49-uc0-68328fb.patch.gz

. Hitachi H8300 achitecture support
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.49-uc0-h8300.patch.gz

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
Snapgear Pty Ltd                               PHONE:    +61 7 3279 1822
825 Stanley St,                                  FAX:    +61 7 3279 1820
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com












