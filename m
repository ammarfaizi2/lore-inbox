Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129325AbQLWKVi>; Sat, 23 Dec 2000 05:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129383AbQLWKV2>; Sat, 23 Dec 2000 05:21:28 -0500
Received: from AGrenoble-101-1-1-84.abo.wanadoo.fr ([193.251.23.84]:51696 "EHLO
	lyon.ram.loc") by vger.kernel.org with ESMTP id <S129325AbQLWKVW>;
	Sat, 23 Dec 2000 05:21:22 -0500
From: Raphael Manfredi <Raphael_Manfredi@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.0 test13-pre4 causes CDROM ioctl errors
X-Mailer: MH [version 6.8]
Organization: Home, Grenoble, France
Date: Sat, 23 Dec 2000 10:50:42 +0100
Message-ID: <1433.977565042@nice.ram.loc>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since I've installed 2.4.0 test13-pre4, I see the following errors
in my log:

	sr0: CDROM (ioctl) reports ILLEGAL REQUEST.

and xmcd reports:

	CD audio: ioctl error on /dev/scd0: cmd=CDROMVOLCTRL errno=95

This was working fine with 2.4.0 test12-pre5, which was the previous
kernel I was using.

Raphael
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
