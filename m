Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161041AbWHRQsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161041AbWHRQsE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 12:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161044AbWHRQsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 12:48:04 -0400
Received: from [81.2.110.250] ([81.2.110.250]:9939 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1161041AbWHRQsB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 12:48:01 -0400
Subject: Re: /dev/sd*
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Seewer Philippe <philippe.seewer@bfh.ch>, Jeff Garzik <jeff@garzik.org>,
       Gabor Gombas <gombasg@sztaki.hu>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0608181748280.11320@yvahk01.tjqt.qr>
References: <1155144599.5729.226.camel@localhost.localdomain>
	 <20060809212124.GC3691@stusta.de>
	 <1155160903.5729.263.camel@localhost.localdomain>
	 <20060809221857.GG3691@stusta.de>
	 <20060810123643.GC25187@boogie.lpds.sztaki.hu>
	 <44DB289A.4060503@garzik.org> <44E3DFD6.4010504@PicturesInMotion.net>
	 <Pine.LNX.4.61.0608171000220.19847@yvahk01.tjqt.qr>
	 <44E42900.1030905@PicturesInMotion.net>
	 <Pine.LNX.4.61.0608171120260.4252@yvahk01.tjqt.qr>
	 <44E56804.1080906@bfh.ch>
	 <Pine.LNX.4.61.0608181050490.27740@yvahk01.tjqt.qr>
	 <1155913072.28764.3.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0608181748280.11320@yvahk01.tjqt.qr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 18 Aug 2006 18:02:21 +0100
Message-Id: <1155920541.30279.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-08-18 am 17:51 +0200, ysgrifennodd Jan Engelhardt:
> Whatever udev does currently seems good:
> 
> 17:48 shanghai:~ > ls /dev/disk/by-id/*
> /dev/disk/by-id/ata-DIAMOND_250G_2B5400_030400026
> /dev/disk/by-id/ata-DIAMOND_250G_2B5400_030400026-part1
> /dev/disk/by-id/usb-0_USB_DRIVE_0000000000004287
> /dev/disk/by-id/usb-0_USB_DRIVE_0000000000004287-part1

I wouldn't try that on a typical "non technical user", at least except
for Halloween 8)

