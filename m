Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284415AbRL0SZs>; Thu, 27 Dec 2001 13:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284950AbRL0SZj>; Thu, 27 Dec 2001 13:25:39 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:38150 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S284415AbRL0SZa>; Thu, 27 Dec 2001 13:25:30 -0500
Date: Thu, 27 Dec 2001 10:29:09 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Time Slice Split Scheduler 2nd ...
In-Reply-To: <Pine.LNX.4.33.0112270823380.2319-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.40.0112271026540.1558-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Dec 2001, Linus Torvalds wrote:

>
> On Wed, 26 Dec 2001, Davide Libenzi wrote:
> >
> > This is the second version of the Time Slice Split Scheduler that
> > separates the concept of time slice from the concept of dynamic priority.
>
> Looks good to me. Applied.

two solutions :

1) you wait to apply that i'll collect statistical dyn_prio data and i'll
	tune the PROC_CHANGE_PENALTY values

2) i'll post a subsequent patch to fix that




- Davide


