Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317308AbSGIGHW>; Tue, 9 Jul 2002 02:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317309AbSGIGHV>; Tue, 9 Jul 2002 02:07:21 -0400
Received: from pacific.moreton.com.au ([203.143.238.4]:52699 "EHLO
	dorfl.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id <S317308AbSGIGHU>; Tue, 9 Jul 2002 02:07:20 -0400
Message-ID: <3D2A7DD9.90503@snapgear.com>
Date: Tue, 09 Jul 2002 16:08:25 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Announce: 2.5.25uc0 patch for mmu-less CPU's
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi All,

I am making a concerted effort (probably in vain :-)
to keep the uClinux (MMU-less support) up to date with
the 2.5 series kernels.

I am keeping patches at:

   http://www.uclinux.org:/pub/uClinux/uClinux-2.5.x/

The most current is linux-2.5.25uc0.patch. It seems
to work pretty well (at least on the target boards I
try it on).

I am mainly working on the ColdFire CPU architecture
support, since that is the hardware I have at hand.

Regards
Greg



------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
SnapGear Pty Ltd                               PHONE:    +61 7 3435 2888
825 Stanley St,                                  FAX:    +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia              WEB:   www.snapgear.com

