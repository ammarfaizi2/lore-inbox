Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317855AbSHLKvY>; Mon, 12 Aug 2002 06:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317858AbSHLKvY>; Mon, 12 Aug 2002 06:51:24 -0400
Received: from mx9.mail.ru ([194.67.57.19]:52485 "EHLO mx9.mail.ru")
	by vger.kernel.org with ESMTP id <S317855AbSHLKvY>;
	Mon, 12 Aug 2002 06:51:24 -0400
From: "Samium Gromoff" <_deepfire@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5 and DRM/3D infrastructure?
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: 192.168.231.213 via proxy [80.79.67.2]
Date: Mon, 12 Aug 2002 14:55:12 +0400
Reply-To: "Samium Gromoff" <_deepfire@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E17eCqu-000I7Y-00@f2.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Couldn't support be in user space? The kernel doesnt even come with a
bootloader,
> 3d is more xfree86 ish...
   Currently XFree86 requires a kernel DRM loaded
 in order to have _any_ 3D acceleration.

   So the range of 3D accelerated cards boils down to those
 which have appropriate kernel code.

   That reminds myself that me having a Fire GL 1000pro which
 is a perfect 3d accelerator can only use inderect Mesa
 rendering capabilities, which is indeed sad.

---
cheers,
Samium Gromoff
________________
__________________________

