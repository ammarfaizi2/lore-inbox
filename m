Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263238AbTHVOES (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 10:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263373AbTHVOER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 10:04:17 -0400
Received: from mta02bw.bigpond.com ([144.135.24.138]:37846 "EHLO
	mta02bw.bigpond.com") by vger.kernel.org with ESMTP id S263238AbTHVOEJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 10:04:09 -0400
Date: Sat, 23 Aug 2003 00:02:23 +1000
From: Greg Ungerer <gerg@snapgear.com>
Subject: [PATCH]: linux-2.6.0-test3-uc0 (MMU-less fix ups)
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <3F46226F.1080505@snapgear.com>
Organization: SnapGear
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.4) Gecko/20030624
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi All,

An update of the uClinux (MMU-less) fixups against linux-2.6.0-test3.
No major changes, biggest change is some printk cleanups from the
kernel janitors.

You can get it at:

http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.6.0-test3-uc0.patch.gz

Changelog:

. port up to 2.6.0-test3             me
. printk cleanup                     Randy Dunlop
                                      Warren Layton
                                      Kernel Janitors

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Dude       EMAIL:     gerg@snapgear.com
Snapgear Pty Ltd                            PHONE:       +61 7 3279 1822
825 Stanley St,                             FAX:         +61 7 3279 1820
Woolloongabba, QLD, 4102, Australia         WEB: http://www.SnapGear.com


























