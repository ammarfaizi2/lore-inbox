Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132890AbRADUcV>; Thu, 4 Jan 2001 15:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132986AbRADUcL>; Thu, 4 Jan 2001 15:32:11 -0500
Received: from patan.Sun.COM ([192.18.98.43]:34757 "EHLO patan.sun.com")
	by vger.kernel.org with ESMTP id <S132890AbRADUcH>;
	Thu, 4 Jan 2001 15:32:07 -0500
Message-ID: <3A54DEBF.794C2E6A@sun.com>
Date: Thu, 04 Jan 2001 12:36:15 -0800
From: ludovic fernandez <ludovic.fernandez@sun.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.14-15 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: nigel@nrg.org
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.0-prerelease: preemptive kernel.
In-Reply-To: <Pine.LNX.4.05.10101041157540.4778-100000@cosmic.nrg.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Nigel,

Nigel Gamble wrote:

>
> Hi Ludo,
>
> I didn't realise you were still working on this.  Did you know that
> I am also?  Our most recent version is at:
>
> ftp://ftp.mvista.com/pub/Area51/preemptible_kernel/
>

I was on vacation and had a little time to kill...
Going through your README, you seem much more
advanced than this simple patch.

>
> although I have yet to put up a 2.4.0-prerelease patch (coming soon).
> We should probably pool our efforts on this for 2.5.
>

Agreed.
Right now I will be interested to run some benchmarks (latency but
also performance) to see how the system is disturbed by beeing
preemptable. I'm little bit lost on this and I don't know where to start.
Do you have any pointers on benchmark suites I could run ?
Also, maybe it's a off topic subject now....

Ludo.



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
