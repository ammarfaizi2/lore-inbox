Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289016AbSAIUxp>; Wed, 9 Jan 2002 15:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289017AbSAIUxf>; Wed, 9 Jan 2002 15:53:35 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:10514 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S287835AbSAIUxV>; Wed, 9 Jan 2002 15:53:21 -0500
Date: Wed, 9 Jan 2002 12:58:36 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Ingo Molnar <mingo@elte.hu>
cc: lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Mike Kravetz <kravetz@us.ibm.com>, Anton Blanchard <anton@samba.org>,
        george anzinger <george@mvista.com>
Subject: Re: [patch] O(1) scheduler, -G1, 2.5.2-pre10, 2.4.17
In-Reply-To: <Pine.LNX.4.33.0201091824570.5876-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.40.0201091256130.1595-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jan 2002, Ingo Molnar wrote:

>
> this is the latest update of the O(1) scheduler:
>
> 	http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.5.2-pre10-G1.patch
>
>         http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.4.17-G1.patch
>
[...]

Ingo, on my dual cpu ( PIII 733 ) i've got the same results for both

chat 20 1000
hackbench 200

High floating values but almost the same average.




- Davide


