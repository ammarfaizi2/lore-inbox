Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267867AbTBKOdh>; Tue, 11 Feb 2003 09:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267868AbTBKOdg>; Tue, 11 Feb 2003 09:33:36 -0500
Received: from mta02ps.bigpond.com ([144.135.25.134]:64237 "EHLO
	mta02ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S267867AbTBKOdf>; Tue, 11 Feb 2003 09:33:35 -0500
Message-ID: <3E490C3E.4010107@snapgear.com>
Date: Wed, 12 Feb 2003 00:44:14 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH]: linux-2.5.60-uc0 (MMU-less fix ups)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

An update of the uClinux (MMU-less) fixups against 2.5.60.
Nothing much new, this is just keeping the fixes up to date.
Quite a number of small fixes needed for 2.5.59 -> 2.5.60.

http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.60-uc0.patch.gz


Also updated:

. Motorola 68328 framebuffer driver
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.60-uc0-68328fb.patch.gz

. Hitachi H8300 achitecture support
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.60-uc0-h8300.patch.gz

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
Snapgear Pty Ltd                               PHONE:    +61 7 3279 1822
825 Stanley St,                                  FAX:    +61 7 3279 1820
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com














