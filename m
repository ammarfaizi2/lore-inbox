Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318841AbSG0W1m>; Sat, 27 Jul 2002 18:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318842AbSG0W1m>; Sat, 27 Jul 2002 18:27:42 -0400
Received: from mta06bw.bigpond.com ([139.134.6.96]:1760 "EHLO
	mta06bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S318841AbSG0W1l>; Sat, 27 Jul 2002 18:27:41 -0400
Message-ID: <3D432025.3000901@snapgear.com>
Date: Sun, 28 Jul 2002 08:35:17 +1000
From: gerg <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.0.0) Gecko/20020530
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH]: MMU-less patches against 2.5.29
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi All,

Latest uClinux (MMU-less support) patches against
Linux 2.5.29 are available at:

http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.29uc0.patch.gz

Some cleanups of CONFIG_NO_MMU. Size of change against
some mainline files reduced a bit. Overall a little bit
cleaner.

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
Snapgear Pty Ltd                               PHONE:    +61 7 3279 1822
825 Stanley St,                                  FAX:    +61 7 3279 1820
Woolloongabba, QLD, 4102, Australia              WEB:   www.snapgear.com


