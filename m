Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262756AbVCXJ5j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262756AbVCXJ5j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 04:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262758AbVCXJ5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 04:57:38 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:53727 "EHLO
	mailout1.samsung.com") by vger.kernel.org with ESMTP
	id S262756AbVCXJ5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 04:57:36 -0500
Date: Thu, 24 Mar 2005 18:56:17 +0900
From: "Hyok S. Choi" <hyok.choi@samsung.com>
Subject: [PATCH] the nommu support for ARM linux 2.6.10
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk,
       uClinux development list <uclinux-dev@uclinux.org>,
       CE Linux Developers List <celinux-dev@tree.celinuxforum.org>
Cc: rmk@arm.linux.org.uk
Message-id: <0IDU00M02OZXJG@mmp1.samsung.com>
Organization: Samsung Electronics Co.,Ltd.
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Thread-index: AcUwV7i2VXLKJ/ckQjSLot1EE1hS4g==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
 
I'm glad to release the first MPU and NO-MMU support patch for ARM linux
2.6.10 at :
http://opensrc.sec.samsung.com/download/linux-2.6.10-hsc0.patch.gz

Previously, it was released as "armnommu" architecture which was called
uClinux/ARM and now is merged with "arm" architecture. You can select the
memory management type "MMU" for linux and "MPU" / "NONE" for uClinux at the
kernel configuration menu. Currently, the ATMEL, S5C7375, S3C24A0 platform
is tested.

I'm working on 2.6.11.5 patch, and it will be provided soon.
 
It would be great if you give me some suggestions.
 
Best Regards,
Hyok

----
HYOK S. CHOI
Digital Media R&D Center, Samsung Electronics Co.,Ltd.
tel: +82-31-200-8594/5723  fax: +82-31-200-3427
e-mail: hyok.choi@samsung.com
[Linux 2.6 MPU/noMMU Kernel Maintainer] http://opensrc.sec.samsung.com

