Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261900AbSLJOsQ>; Tue, 10 Dec 2002 09:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261950AbSLJOsP>; Tue, 10 Dec 2002 09:48:15 -0500
Received: from mta01ps.bigpond.com ([144.135.25.133]:13254 "EHLO
	mta01ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S261900AbSLJOsO>; Tue, 10 Dec 2002 09:48:14 -0500
Message-ID: <3DF60116.5080200@snapgear.com>
Date: Wed, 11 Dec 2002 00:58:30 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH]: linux-2.5.51-uc0 (MMU-less fix ups)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

An update of the uClinux (MMU-less) fixups against 2.5.51.
Nothing much new, this is just keeping the fixes up to date.

http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.51-uc0.patch.gz

Changelog:

1. patch against 2.5.51                  (me)
2. binfmt_flat optional args on stack    (Miles Bader)
3. h8300 architecture support updates    (Yoshinori Sato)
4. gzip header checks in binfmt_flat     (Ingo Oeser)

Also updated:

. Motorola 68328 framebuffer driver
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.51-uc0-68328fb.patch.gz

. Hitachi H8300 achitecture support
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.51-uc0-h8300.patch.gz

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
Snapgear Pty Ltd                               PHONE:    +61 7 3279 1822
825 Stanley St,                                  FAX:    +61 7 3279 1820
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com













