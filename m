Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314492AbSDWXr1>; Tue, 23 Apr 2002 19:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314491AbSDWXr0>; Tue, 23 Apr 2002 19:47:26 -0400
Received: from taco.vianet.on.ca ([209.91.128.11]:7296 "HELO smtp.vianet.ca")
	by vger.kernel.org with SMTP id <S314489AbSDWXrZ>;
	Tue, 23 Apr 2002 19:47:25 -0400
Message-ID: <029201c1eb21$40f216a0$a764a8c0@tdnlaptop>
From: "Reid Sutherland" <reid@vianet.ca>
To: <linux-kernel@vger.kernel.org>
Subject: FIXED BUG 2.4.18: Invalidate: busy buffer with raid0.
Date: Tue, 23 Apr 2002 19:47:39 -0400
Organization: ViaNet Communications Inc.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From my testing the bug where the system would not reboot because of an
infinite "Invalidate: busy buffer" is only in the 2.4.18 kernel.

It seems to only apply to a configured raid0 root drive.

Thanks,

-reid

