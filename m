Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273281AbRIWGuE>; Sun, 23 Sep 2001 02:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273298AbRIWGtz>; Sun, 23 Sep 2001 02:49:55 -0400
Received: from samar.sasken.com ([164.164.56.2]:22486 "EHLO samar.sasken.com")
	by vger.kernel.org with ESMTP id <S273281AbRIWGtq>;
	Sun, 23 Sep 2001 02:49:46 -0400
From: "Nirranjan.K" <nirran@sasken.com>
Subject: Bottom halves, task queues invokation
Date: Sun, 23 Sep 2001 12:15:47 +0530
Message-ID: <9ok0mr$f4q$1@ncc-k.sasi.com>
X-Newsreader: Microsoft Outlook Express 4.72.3110.5
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.3110.3
To: linux-kernel@vger.kernel.org
X-News-Gateway: ncc-z.sasken.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In case of

kernel thread is running on behalf of user process. In meantime a timer
interrupt arrives(slow interrupt). Now after end of timer interrupt are
Bottom halves, task queues invoked ? (offcourse Scheduler is not invoked as
kernel is not pre emptive)

Please clarify .

Thanks,
Nirranjan.K


