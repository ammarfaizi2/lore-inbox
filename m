Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266233AbTCENfI>; Wed, 5 Mar 2003 08:35:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266292AbTCENfH>; Wed, 5 Mar 2003 08:35:07 -0500
Received: from mta04ps.bigpond.com ([144.135.25.136]:9928 "EHLO
	mta04ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S266233AbTCENfG>; Wed, 5 Mar 2003 08:35:06 -0500
Message-ID: <3E65FFDA.6050600@snapgear.com>
Date: Wed, 05 Mar 2003 23:47:06 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH]: linux-2.5.64-uc0 (MMU-less fix ups)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

An update of the uClinux (MMU-less) fixups against 2.5.64.
A few minor fixups going from 2.5.53 to 2.5.64, and some
reworking of the ColdFire CPU timer support.

http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.64-uc0.patch.gz


Also updated:

. Motorola 68328 framebuffer driver
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.64-uc0-68328fb.patch.gz

. Hitachi H8300 achitecture support
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.64-uc0-h8300.patch.gz

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
Snapgear Pty Ltd                               PHONE:    +61 7 3279 1822
825 Stanley St,                                  FAX:    +61 7 3279 1820
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com
















