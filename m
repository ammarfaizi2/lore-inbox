Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264958AbRFZOsQ>; Tue, 26 Jun 2001 10:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264959AbRFZOsH>; Tue, 26 Jun 2001 10:48:07 -0400
Received: from [32.97.182.101] ([32.97.182.101]:20733 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264958AbRFZOsA>;
	Tue, 26 Jun 2001 10:48:00 -0400
Importance: Normal
Subject: Re: all processes waiting in TASK_UNINTERRUPTIBLE state
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, mingo@elte.hu
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF29D2C834.F627AA03-ON85256A77.0050F2F6@pok.ibm.com>
From: "Bulent Abali" <abali@us.ibm.com>
Date: Tue, 26 Jun 2001 10:47:12 -0400
X-MIMETrack: Serialize by Router on D01ML233/01/M/IBM(Release 5.0.8 |June 18, 2001) at
 06/26/2001 10:46:30 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>> I am running in to a problem, seemingly a deadlock situation, where
almost
>> all the processes end up in the TASK_UNINTERRUPTIBLE state.   All the
>
>could you try to reproduce with this patch applied on top of
>2.4.6pre5aa1 or 2.4.6pre5 vanilla?

Andrea,
I would like try your patch but so far I can trigger the bug only when
running TUX 2.0-B6 which runs on 2.4.5-ac4.  /bulent



