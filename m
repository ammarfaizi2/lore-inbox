Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264048AbUGFPuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264048AbUGFPuG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 11:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264054AbUGFPuG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 11:50:06 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:23231 "EHLO
	mailout1.samsung.com") by vger.kernel.org with ESMTP
	id S264048AbUGFPt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 11:49:58 -0400
Date: Wed, 07 Jul 2004 00:48:04 +0900
From: "Hyok S. Choi" <hyok.choi@samsung.com>
Subject: [PATCH] armnommu patch for 2.6.7 is available!
To: linux-arm-kernel@lists.arm.linux.org.uk,
       Linux-Kernel List <linux-kernel@vger.kernel.org>,
       uClinux development list <uclinux-dev@uclinux.org>
Message-id: <0I0F00F2RTB779@mmp1.samsung.com>
Organization: Samsung Electronics Co.,Ltd.
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Thread-index: AcRjcJ/JtIdErBkxSA6yyjKze+7fmw==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Glad to introduce 2.6.7-hsc0 patch set, the armnommu support for linux-2.6.7
kernel.
Which means uClinux/ARM patch against 2.6.7 in alternative. You can find the
patch at :
http://opensrc.sec.samsung.com
or directly,
http://opensrc.sec.samsung.com/download/linux-2.6.7-hsc0.patch.gz

It is generated against vanilla 2.6.7 kernel.

ChangeLog:
   a. new platform (s3c4510b,ESPD) is supported, with 4510b specialized
cache codes and ethernet driver.
       by Curt Brune [curt@acm.org] (thanks!)
   b. new platform (s3c44b0x) is supported, with 44b0x cache codes and
rtl8019.
       by Nickmit Zheng [nickmit_zheng@eastday.com] (thanks!)
   c. merged with internal 2.6.6-hsc1 patch and several fixes for 2.6.7.

Best Regards,
Hyok

P.S. : armnommu architecture directory have been used for uClinux/ARM
support, like m68knommu.
     Some people suggest merging into arm architecture, and I have a part of
the idea as my plan sent to RMK.
     If anyone has a good idea to co-operate with arm and armnommu without
maintaining trouble,
     please let me know. :-)
    

<EOT>

CHOI, HYOK-SUNG
Engineer (Linux System Software)
S/W Platform Lab, Digital Media R&D Center
Samsung Electronics Co.,Ltd.
tel: +82-31-200-8594  fax: +82-31-200-3427
e-mail: hyok.choi@samsung.com <mailto:hyok.choi@samsung.com> 
Linux 2.6 armnommu maintainer : http://opensrc.sec.samsung.com


 

 


