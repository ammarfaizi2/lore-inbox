Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262323AbUKWIPf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262323AbUKWIPf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 03:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262327AbUKWIPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 03:15:35 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:42433 "EHLO
	mailout2.samsung.com") by vger.kernel.org with ESMTP
	id S262323AbUKWIPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 03:15:30 -0500
Date: Tue, 23 Nov 2004 17:13:38 +0900
From: "Hyok S. Choi" <hyok.choi@samsung.com>
Subject: [PATCH]: linux-2.6.9-hsc0 (MMU-less ARM fixups)
In-reply-to: <41A2B075.8030409@snapgear.com>
To: Linux-Kernel List <linux-kernel@vger.kernel.org>
Cc: Greg Ungerer <gerg@snapgear.com>, David MaCullough <davidm@snapgear.com>
Message-id: <0I7M00MCNHJ6PW@mmp2.samsung.com>
Organization: Samsung Electronics Co.,Ltd.
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Thread-index: AcTRDfw/1PRwucZVSp+zpDKk/EpBYgAI1l0w
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

An update for MMU-less ARM support fixups against 2.6.9.

http://opensrc.sec.samsung.com/download/linux-2.6.9-hsc0.patch.gz

ChangeLog:
   . armnommu patch merging w/2.6.9     me
   . new s3c24a0 platform is supported     HeeChul Yun
   . arm926ej uclinux support     me
   . trap handler support     HeeChul Yun
   . dma consistent interface support     me
   . newer toolchain(i.e. gcc 3.4) support     me
   . defconfig update for all platforms     me

Regards,
Hyok S. Choi
SPL DMR&D Samsung Electronics
linux armnommu project : http://opensrc.sec.samsung.com

