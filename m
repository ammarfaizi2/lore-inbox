Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261671AbUC0Ja0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 04:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbUC0Ja0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 04:30:26 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:46273 "EHLO
	mailout3.samsung.com") by vger.kernel.org with ESMTP
	id S261706AbUC0JaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 04:30:22 -0500
Date: Sat, 27 Mar 2004 18:29:19 +0900
From: "Hyok S. Choi" <hyok.choi@samsung.com>
Subject: [ANNOUNCE] 2.6.4-hsc1 patch for MMU-less ARM is available.
To: uClinux development list <uclinux-dev@uclinux.org>,
       Linux-Kernel List <linux-kernel@vger.kernel.org>,
       linux-arm-kernel@lists.arm.linux.org.uk
Message-id: <000401c413dd$fb0649d0$7dc2dba8@dmsst.net>
Organization: Samsung Electronics Co.,Ltd.
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Mailer: Microsoft Outlook, Build 10.0.4510
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Importance: Normal
X-Priority: 3 (Normal)
X-MSMail-priority: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello ARM users!

MMU-less ARM patch against linux-2.6.4 kernel, linux-2.6.4-hsc1 patch is
available at:
http://adam.kaist.ac.kr/~hschoe

The ATMEL AT91xx(ARM7TDMI) platform support is added, which means
GDB/ARMulator is supported also. And proc-arm940.S is included. (contributed
by Hee-Chul Yun)

You can download it directly at :
http://adam.kaist.ac.kr/~hschoe/download/linux-2.6.4-hsc1.patch.gz

This patch pending to be merged to 2.6.4-uc0 patch.

Happy Hacking!

Regards,
Hyok S. Choi

<EOT>

CHOI, HYOK-SUNG
Engineer (Linux System Software)
S/W Platform Lab, Digital Media R&D Center
Samsung Electronics Co.,Ltd.
tel: +82-31-200-8594  fax: +82-31-200-3427
e-mail: hyok.choi@samsung.com

[compile&run]
main(a){printf(a,34,a="main(a){printf(a,34,a=%c%s%c,34);}",34);}

 
 

