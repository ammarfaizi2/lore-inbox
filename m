Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264919AbUHWPCA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264919AbUHWPCA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 11:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264917AbUHWPCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 11:02:00 -0400
Received: from [212.209.10.220] ([212.209.10.220]:50084 "EHLO
	miranda.se.axis.com") by vger.kernel.org with ESMTP id S264808AbUHWPB5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 11:01:57 -0400
From: "Mikael Starvik" <mikael.starvik@axis.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4] CRIS architecture update
Date: Mon, 23 Aug 2004 17:01:55 +0200
Message-ID: <BFECAF9E178F144FAEF2BF4CE739C66818F50C@exmail1.se.axis.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As requested on this list a while ago I send patches for the
CRIS architecture here before they are sent to Marcelo/Andrew.
Most of you doesn't care at all and that's just fine.

If you have any objections/improvements or want time to review 
anything notify me during the next few days. If I hear
complete silence the patches will go in next week.

Also tell me if you want this in any other format.

The most interesting things included in the patches are:

IDE driver modifications for >= 2.4.21
Kernel debug console cleanups and improvements
Added support for isoc out in USB driver
Performance improvement by implementing MMU refill in assembler
Improved multiple interrupt handling

/Mikael (CRIS maintainer)

