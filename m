Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282850AbRK0Hnh>; Tue, 27 Nov 2001 02:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282847AbRK0Hms>; Tue, 27 Nov 2001 02:42:48 -0500
Received: from smtp-rt-1.wanadoo.fr ([193.252.19.151]:59345 "EHLO
	anagyris.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S282844AbRK0Hmd>; Tue, 27 Nov 2001 02:42:33 -0500
Date: Tue, 27 Nov 2001 08:41:50 +0100
From: Eric Streit <Eric.Streit@wanadoo.fr>
To: linux-kernel@vger.kernel.org
Subject: one missing line in ov511.c
Message-ID: <20011127084150.A11807@sarah.maison.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

a short mail to report a small bug in "ov511.c".
(drivers/usb/ov511.c)

the line defining the kernel version is missing in the kernel 2.2.20.

I downloaded it 2 days ago.

************line  missing**************
static char kernel_version[] = UTS_RELEASE;
************end of line missing********

I am at work, so I have only the 2.2.19 kernel, so I cannot say
the right line, but it's just under the "MODULE_DESCRIPTION" line.

Hope this help,


Eric

Eric.Streit@wanadoo.fr
 
