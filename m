Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289605AbSAJTD3>; Thu, 10 Jan 2002 14:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289596AbSAJTDU>; Thu, 10 Jan 2002 14:03:20 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:46861 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S289586AbSAJTDB>; Thu, 10 Jan 2002 14:03:01 -0500
Date: Thu, 10 Jan 2002 11:08:21 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Mike Kravetz <kravetz@us.ibm.com>
cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>,
        george anzinger <george@mvista.com>
Subject: Re: [patch] O(1) scheduler, -D1, 2.5.2-pre9, 2.4.17
In-Reply-To: <20020110102105.B1162@w-mikek2.des.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.40.0201101107350.1493-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2002, Mike Kravetz wrote:

> On Wed, Jan 09, 2002 at 11:38:33AM -0800, Mike Kravetz wrote:
> >
> > I just kicked off another benchmark run to compare pre10, pre10 & G1
> > patch, pre10 & Davide's patch.
>
> It wasn't a good night for benchmarking.  I had a typo in the
> script to run chat reniced and as a result didn't collect any
> numbers for this.  In addition, the kernel with Davide's patch
> failed to boot with 8 CPUs enabled.  Can't see any '# CPU specific'
> mods in the patch.  In any case, here is what I do have.

Doh !! Do you have a panic dump Mike ?




- Davide


