Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266144AbSKLCuQ>; Mon, 11 Nov 2002 21:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266146AbSKLCuQ>; Mon, 11 Nov 2002 21:50:16 -0500
Received: from pacific.moreton.com.au ([203.143.238.4]:17406 "EHLO
	dorfl.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id <S266144AbSKLCuP>; Mon, 11 Nov 2002 21:50:15 -0500
Message-ID: <3DD06E49.8080309@snapgear.com>
Date: Tue, 12 Nov 2002 12:58:17 +1000
From: gerg@snapgear.com
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH]: linux-2.5.47-uc0 (MMU-less fixups)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi All,

The patch is getting quite small now. Only a handful of
things outstanding, and a couple of new things to go in.

http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.47-uc0.patch.gz

Change log:
1. patch up to 2.5.47                (me)
2. cleanup of kernel/fork.c          (Christoph Hellwig)
3. merge m68knommu entry.S           (me)
4. merge coldfire vector code        (me)
5. v850 tweaks                       (Miles Bader)

I haven't bothered with subsection patches this time, I don't
think they are any help now. I will break this up into small
patches and send to Linus...

Regards
Greg



------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
SnapGear Pty Ltd                               PHONE:    +61 7 3435 2888
825 Stanley St,                                  FAX:    +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com








