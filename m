Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261294AbVECC1b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbVECC1b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 22:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbVECC1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 22:27:31 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:9268 "EHLO
	mailout2.samsung.com") by vger.kernel.org with ESMTP
	id S261294AbVECC12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 22:27:28 -0400
Date: Tue, 03 May 2005 11:25:49 +0900
From: "Hyok S. Choi" <hyok.choi@samsung.com>
Subject: [PATCH] release of the ARM MPU/noMMU support 2.6.11.8-hsc0
To: uClinux development list <uclinux-dev@uclinux.org>,
       linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org
Cc: CE Linux Developers List <celinux-dev@tree.celinuxforum.org>
Message-id: <0IFW003ST6TPYC@mmp1.samsung.com>
Organization: Samsung Electronics Co.,Ltd.
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Thread-index: AcU1BWcNVc0V74LDSaahcUiPaBabRQAAA+EQAF6QSaAGQZe5wA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I'm glad to announce the ARM MPU/noMMU support 2.6.11.8-hsc0 patch at:
http://opensrc.sec.samsung.com/download/linux-2.6.11.8-hsc0.patch.gz

ChangeLog:
- Samsung s3c24a0 Linux support*
- Linux & uClinux dual boot support : Samsung s3c24a0* and ARM Integrator**
- ARM Integrator MPU platforms support**
- ARMv6 supported and tested on arm1136 and arm1156**
- P2001 based 4 additional platforms are supported***

Credits: * me, ** Catalin Marinas, *** Tobias Lorenz

You can reach the project site at : http://opensrc.sec.samsung.com/

Best Regards,
hyok

