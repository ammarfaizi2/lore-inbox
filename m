Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261894AbSJ3Fj5>; Wed, 30 Oct 2002 00:39:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264001AbSJ3Fj5>; Wed, 30 Oct 2002 00:39:57 -0500
Received: from pacific.moreton.com.au ([203.143.238.4]:51408 "EHLO
	dorfl.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id <S261894AbSJ3Fj4>; Wed, 30 Oct 2002 00:39:56 -0500
Message-ID: <3DBF7289.9030602@snapgear.com>
Date: Wed, 30 Oct 2002 15:47:53 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg Ungerer <gerg@snapgear.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: linux-2.5.45-uc0 (MMU-less support)
References: <3DBF7115.8000002@snapgear.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I guess I'll just rename this the linux-2.5.45-uc0-booger-head.patch :-)
It does run on MMU-less targets, if anyone bothers to try it...

Regards
Greg




Greg Ungerer wrote:
> 
> Hi All,
> 
> The latest set of MMU-less support patches are up. You can
> get the all-in-one patch at:
> 
> http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.45-uc0.patch.gz
> 
> Change log:
> 1. patch against 2.5.45
> 2. move arch/m68knommu/platform/5307/bios32.c
> 
> 
> You can get smaller patches here:
> 
> . FEC (5272) and 68360 ethernet drivers
> http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.45-uc0-fec.patch.gz 
> 
> 
> . 68k/ColdFire/v850 serial drivers
> http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.45-uc0-serial.patch.gz 
> 
> 
> . 68328 frame buffer driver
> http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.45-uc0-fb.patch.gz 
> 
> 
> . FLAT file loader
> http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.45-uc0-binflat.patch.gz 
> 
> 
> . m68knommu architecture support
> http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.45-uc0-m68knommu.patch.gz 
> 
> 
> . v850 architecture support
> http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.45-uc0-v850.patch.gz 
> 
> 
> . no VM memory support
> http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.45-uc0-mm.patch.gz 
> 
> 
> Regards
> Greg
> 
> 
> ------------------------------------------------------------------------
> Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
> SnapGear Pty Ltd                               PHONE:    +61 7 3435 2888
> 825 Stanley St,                                  FAX:    +61 7 3891 3630
> Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com
> 
> 
> 
> 
> 

-- 
------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
SnapGear Pty Ltd                               PHONE:    +61 7 3435 2888
825 Stanley St,                                  FAX:    +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com

