Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267041AbSKSEde>; Mon, 18 Nov 2002 23:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267042AbSKSEde>; Mon, 18 Nov 2002 23:33:34 -0500
Received: from pacific.moreton.com.au ([203.143.238.4]:1509 "EHLO
	dorfl.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id <S267041AbSKSEdd>; Mon, 18 Nov 2002 23:33:33 -0500
Message-ID: <3DD9C0FF.8090007@snapgear.com>
Date: Tue, 19 Nov 2002 14:41:35 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH]: linux-2.5.48-uc0 (MMU-less fixups)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi All,

The patch is getting quite small now. Only a handful of
things still outstanding. Quite a few trivial fixup
patches in here...

http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.48-uc0.patch.gz

Change log:
1. patch up to 2.5.48                (me)
2. h8300 architecture support        (Yoshinori Sato)
3. clean up of kernel/sysctl.c       (me)


I have separated out the 68328 frame buffer driver.
Its patch set is now at:

http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.48-uc0-68328fb.patch.gz

And the h8300 support is at:

http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.48-uc0-h8300.patch.gz

Regards
Greg



------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
SnapGear Pty Ltd                               PHONE:    +61 7 3435 2888
825 Stanley St,                                  FAX:    +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com









