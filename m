Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318347AbSGYGwp>; Thu, 25 Jul 2002 02:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318351AbSGYGwp>; Thu, 25 Jul 2002 02:52:45 -0400
Received: from pacific.moreton.com.au ([203.143.238.4]:43750 "EHLO
	dorfl.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id <S318347AbSGYGwo>; Thu, 25 Jul 2002 02:52:44 -0400
Message-ID: <3D3FA130.6020701@snapgear.com>
Date: Thu, 25 Jul 2002 16:56:48 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH]: uClinux (MMU-less) patches against 2.5.28
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi All,

A new set of uClinux (MMU-less) patches agains 2.5.28.
You can get it at:

http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.28uc0.patch.gz

Some amount of hacking was required to support the underlying
interrupt/cli/sti changes. But it seems to work pretty well
on my test boards.

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
SnapGear Pty Ltd                               PHONE:    +61 7 3435 2888
825 Stanley St,                                  FAX:    +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia              WEB:   www.snapgear.com

