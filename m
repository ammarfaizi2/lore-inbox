Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130685AbRC0H6y>; Tue, 27 Mar 2001 02:58:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130768AbRC0H6o>; Tue, 27 Mar 2001 02:58:44 -0500
Received: from 64-42-29-14.atgi.net ([64.42.29.14]:26380 "HELO
	mail.clouddancer.com") by vger.kernel.org with SMTP
	id <S130685AbRC0H6f>; Tue, 27 Mar 2001 02:58:35 -0500
From: Colonel <klink@clouddancer.com>
To: linux-kernel@vger.kernel.org
Cc: paulus@samba.org
Subject: [PATCH] [RESEND] update chipsfb driver
Reply-To: klink@clouddancer.com
Message-Id: <20010327075748.7BC55689E@mail.clouddancer.com>
Date: Mon, 26 Mar 2001 23:57:48 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Linus,

> At present, drivers/video/chipsfb.c can only be used on PPC, and it
> doesn't compile even on PPC.  The patch below makes it compile, and
> by changing it to use the generic inb/outb, means that there is at
> least a chance it can be used on other platforms.  The patch is
> against 2.4.3-pre7, could you apply it please?                                                                                                 

I have an old Planar wall mount with Chips & Tech video, powered by a
T.I. 486DX100 (the BIOS is 7 years old).  I originally bought it to
use the frame buffer in a portable application, and this patch is the
FIRST time I've ever obtained an image.  Thanks!

The colormap is wrong, but at least I have some sort of working device
now.  I shelved the project over a year ago, what's a good site to
come up to speed on?

r
