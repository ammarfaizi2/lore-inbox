Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274513AbRITOWA>; Thu, 20 Sep 2001 10:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274512AbRITOVu>; Thu, 20 Sep 2001 10:21:50 -0400
Received: from samar.sasken.com ([164.164.56.2]:29370 "EHLO samar.sasken.com")
	by vger.kernel.org with ESMTP id <S274510AbRITOVe>;
	Thu, 20 Sep 2001 10:21:34 -0400
From: "Nirranjan.K" <nirran@sasken.com>
Subject: how is TIMER_BH called
Date: Thu, 20 Sep 2001 19:47:57 +0530
Message-ID: <9ocu1t$bj3$1@ncc-k.sasi.com>
X-Newsreader: Microsoft Outlook Express 4.72.3110.5
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.3110.3
To: linux-kernel@vger.kernel.org
X-News-Gateway: ncc-z.sasken.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I read that Bottom halves are called only at the end of slow interrupts not
after fast interrupts. Timer tick is a fast interrupt(SA_INTERRUPT - set).
Then how is TIMER_BH called ? Please clarify.

Thanks in advance,
Nirranjan.K



