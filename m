Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288923AbSAIR5G>; Wed, 9 Jan 2002 12:57:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288940AbSAIR44>; Wed, 9 Jan 2002 12:56:56 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:51724 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S288923AbSAIR4u>; Wed, 9 Jan 2002 12:56:50 -0500
Date: Wed, 9 Jan 2002 10:02:02 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Mike Kravetz <kravetz@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>,
        georgr anzinger <george@mvista.com>
Subject: Re: [patch] O(1) scheduler, -D1, 2.5.2-pre9, 2.4.17
In-Reply-To: <20020109143242.013a0a31.rusty@rustcorp.com.au>
Message-ID: <Pine.LNX.4.40.0201091001220.1595-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jan 2002, Rusty Russell wrote:

> On Tue, 8 Jan 2002 21:05:23 -0800 (PST)
> Davide Libenzi <davidel@xmailserver.org> wrote:
> > Mike can you try the patch listed below on custom pre-10 ?
> > I've got 30-70% better performances with the chat_s/c test.
>
> I'd encourage you to use hackbench, which is basically "the part of chat_c/s
> that is interesting".
>
> And I'd encourage you to come up with a better name, too 8)

Got it. I'll try.



- Davide


