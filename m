Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261619AbUCPNis (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 08:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbUCPNis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 08:38:48 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:33015 "EHLO
	mailout3.samsung.com") by vger.kernel.org with ESMTP
	id S261619AbUCPNiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 08:38:46 -0500
Date: Tue, 16 Mar 2004 22:37:46 +0900
From: "Hyok S. Choi" <hyok.choi@samsung.com>
Subject: [PATCH] linux-2.6.4-hsc0 patch for MMU-less ARM available.
To: linux-kernel@vger.kernel.org
Message-id: <00a401c40b5b$de2f7c80$7dc2dba8@dmsst.net>
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

I announce the MMU-less ARM patch against linux-2.6.4 kernel,
linux-2.6.4-hsc0 patch on the download section of
http://adam.kaist.ac.kr/~hschoe/

 This port includes several bug fixes and code clean-up. Some of them is
referenced from arm-linux and wishing to be synchronized. Please feel free
to contact me for any suggestions. 

You can download it directly at :
http://adam.kaist.ac.kr/~hschoe/download/linux-2.6.4-hsc0.patch.gz

Greg would merge this patch to 2.6.4-uc0 patch.

Happy Hacking!

Regards,
Hyok

<EOT>

CHOI, HYOK-SUNG
Engineer (Linux System Software)
S/W Platform Lab, Digital Media R&D Center
Samsung Electronics Co.,Ltd.
tel: +82-31-200-8594  fax: +82-31-200-3427
e-mail: hyok.choi@samsung.com

[compile&run]
main(a){printf(a,34,a="main(a){printf(a,34,a=%c%s%c,34);}",34);}

 
 

