Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129375AbRAXXB2>; Wed, 24 Jan 2001 18:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129401AbRAXXBS>; Wed, 24 Jan 2001 18:01:18 -0500
Received: from gtei2.bellatlantic.net ([199.45.40.146]:42679 "EHLO
	gtei2.bellatlantic.net") by vger.kernel.org with ESMTP
	id <S129375AbRAXXBD>; Wed, 24 Jan 2001 18:01:03 -0500
Message-ID: <3A6F5E59.4EF0F2CE@neuronet.pitt.edu>
Date: Wed, 24 Jan 2001 17:59:37 -0500
From: "Rafael E. Herrera" <raffo@neuronet.pitt.edu>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: f5ibh <f5ibh@db0bm.ampr.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: display problem with matroxfb
In-Reply-To: <200101242217.XAA21787@db0bm.ampr.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

f5ibh wrote:
> > XF4.0.x should work reasonably well. Or you can run accelerated XF on mga:
> > matroxfb is compatible with accelerated XF 3.3.x, and with accelerated
> > XF 4.0.x WITHOUT enabled DRI (as DRI code reprograms hardware even if
> > X are on background) (and 'Option "UseFBDev"' is required if you are
> > using both heads of G400/G450 with XF4).
> 
> I am lost !!
> I've XFree86 Version 3.3.6
> I've and ATI AGP video card with an S3 chipset and 4Mb plus the Matrox Mystique
> (PCI) with 8Mb.

I think XFree86 3.3.6 will support one card at the time, not both, so
you won't get 
a dual-head server with that version. Upgrade to XFree86 4.0.x.

-- 
     Rafael
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
