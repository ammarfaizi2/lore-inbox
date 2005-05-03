Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261313AbVECCh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbVECCh1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 22:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261314AbVECCh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 22:37:27 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:28041 "EHLO
	mailout1.samsung.com") by vger.kernel.org with ESMTP
	id S261313AbVECChN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 22:37:13 -0400
Date: Tue, 03 May 2005 11:35:32 +0900
From: "Hyok S. Choi" <hyok.choi@samsung.com>
Subject: [Benchmark] Linux 2.6.11.6 ARM MMU mode vs. noMMU mode vs. MVista
 2.4.20
In-reply-to: 
To: uClinux development list <uclinux-dev@uclinux.org>,
       linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org
Cc: CE Linux Developers List <celinux-dev@tree.celinuxforum.org>
Message-id: <0IFW003QR79WYC@mmp1.samsung.com>
Organization: Samsung Electronics Co.,Ltd.
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Thread-index: AcU1BWcNVc0V74LDSaahcUiPaBabRQAAA+EQAF6QSaAGQZe5wAAAYLmA
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI,

I just put an newer lmbench lat_ctx benchmark result chart,
among linux 2.6.11.6 noMMU mode vs. MMU mode vs. montavista
linux(2.4.20-mvista) at:
http://opensrc.sec.samsung.com/document/ctx-perf-linux-2.6.11.6.pdf

you can find some graphs also at :
http://opensrc.sec.samsung.com/document.html

Hyok



