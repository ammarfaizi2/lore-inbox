Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266405AbUBERPI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 12:15:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266413AbUBERPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 12:15:08 -0500
Received: from virgo.i-cable.com ([203.83.111.75]:26758 "HELO
	virgo.i-cable.com") by vger.kernel.org with SMTP id S266405AbUBERPE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 12:15:04 -0500
Message-ID: <164601c3ec06$be8bd5a0$b8560a3d@kyle>
From: "Kyle" <kyle@southa.com>
To: <linux-kernel@vger.kernel.org>
Subject: ICH5 with 2.6.1 very slow
Date: Fri, 6 Feb 2004 00:40:14 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problem with ICH5?
I read the list web, so please CC my email, thanks.

P4 2.6G HT, 2GB Ram, ICH5, WD250GB/8M x 2  (md raid 1), kernel 2.6.1
Timing buffer-cache reads: 128 MB in 0.14 seconds =882.89 MB/sec
Timing buffered disk reads: 64 MB in 2.14 seconds = 29.93 MB/sec

Celeron 1.3T, 1GB Ram, SIS630/5513, WD80GB/2M x 2 (md raid 1), kernel 2.6.1
Timing buffer-cache reads: 128 MB in 1.24 seconds =103.08 MB/sec
Timing buffered disk reads: 64 MB in 1.83 seconds = 35.00 MB/sec

Celeron 2.5G, 512MB Ram, i845/ICH4, WD120GB/8M x 2 (md raid 1), redhat
kernel 2.4.20
Timing buffer-cache reads:   128 MB in  0.35 seconds =365.71 MB/sec
Timing buffered disk reads:  64 MB in  1.38 seconds = 46.38 MB/sec

Kyle






