Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131743AbRBMOuw>; Tue, 13 Feb 2001 09:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131725AbRBMOul>; Tue, 13 Feb 2001 09:50:41 -0500
Received: from colorfullife.com ([216.156.138.34]:17927 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S131721AbRBMOu2>;
	Tue, 13 Feb 2001 09:50:28 -0500
Message-ID: <3A8949B5.6BEDA269@colorfullife.com>
Date: Tue, 13 Feb 2001 15:50:29 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: "N. Jason Kleinbub" <jkleinbub@navtechinc.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Selects on dirs/files.
In-Reply-To: <3A894282.5070909@navtechinc.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"N. Jason Kleinbub" wrote:
> 
> People,
> 
> Not sure where to go from here but ....
> 
>         ( Yes I have read the FAQ )
> 
> For practical reasons, I have created some modification to the
> Linux kernel.  These changes were to make our implementation of
> software more convenient (elegant).  Essentially, I have modified the
> select() calls to allow the non-trivial use of directories as an 'fd'.
>
Have you checked the F_NOTIFY fcntl()?

If yes, what's the difference between your patch and F_NOTIFY?

--
	Manfred
