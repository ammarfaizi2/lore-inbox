Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135917AbREBV5t>; Wed, 2 May 2001 17:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135992AbREBV5j>; Wed, 2 May 2001 17:57:39 -0400
Received: from oboe.it.uc3m.es ([163.117.139.101]:44549 "EHLO oboe.it.uc3m.es")
	by vger.kernel.org with ESMTP id <S135917AbREBV51>;
	Wed, 2 May 2001 17:57:27 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200105022156.f42LulT20491@oboe.it.uc3m.es>
Subject: Re: [OT] Interrupting select.
In-Reply-To: <JKEGJJAJPOLNIFPAEDHLAEJGCOAA.laramie.leavitt@btinternet.com> from
 "Laramie Leavitt" at "May 2, 2001 10:46:03 pm"
To: lar@cs.york.ac.uk
Date: Wed, 2 May 2001 23:56:47 +0200 (MET DST)
CC: "Linux Kernel" <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago Laramie Leavitt wrote:"
> I think that this is slightly off-topic, but I figure that

I'll second this one (waaay off topic for the kernel list,
but ...)

> someone here knows the answer or where to point me to the
> answer.  Please respond privately so the entire list is not
> spamed by the response.

What IS the magic combination that makes select interruptible
by honest-to-goodness non-blocked signals!

> I am writing a threaded network daemon using a thread per
> connection model (I know, it is not the most effective, but

Me TOO.

> in shared memory.  I am looking for a way to send the thread a 
> signal or event to cause the thread to abort the read or select
> call when data is available.

Hear hear.

:-)

(followups to comp.os.linux.system or something like that)


Peter
