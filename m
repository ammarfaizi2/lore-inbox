Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278325AbRKDWJZ>; Sun, 4 Nov 2001 17:09:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279106AbRKDWJO>; Sun, 4 Nov 2001 17:09:14 -0500
Received: from Expansa.sns.it ([192.167.206.189]:48656 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S278325AbRKDWJL>;
	Sun, 4 Nov 2001 17:09:11 -0500
Date: Sun, 4 Nov 2001 23:09:12 +0100 (CET)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Linus Torvalds <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
In-Reply-To: <9s43m9$doh$1@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0111042308340.32009-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 4 Nov 2001, Linus Torvalds wrote:

> In article <20011104172742Z16629-26013+37@humbolt.nl.linux.org>,
> Daniel Phillips  <phillips@bonn-fries.net> wrote:
> >On November 4, 2001 05:45 pm, Tim Jansen wrote:
> >> > The dot-proc file is basically a binary encoding of Lisp (or XML), e.g. it
> >> > is a list of elements, wherein an element can itself be a list (or a
> >>
> >> Why would anybody want a binary encoding?
> >
> >Because they have a computer?
>
> That's a stupid argument.
>
> The computer can parse anything.
>
> It's us _humans_ that are limited at parsing. We like text interfaces,
> because that's how we are brought up. We aren't good at binary, and
> we're not good at non-linear, "structured" interfaces.
>
> In contrast, a program can be taught to parse the ascii files quite
> well, and does not have the inherent limitations we humans have. Sure,
> it has _other_ limitations, but /proc being ASCII is sure as hell not
> one of them.
>
> In short: /proc is ASCII, and will so remain while I maintain a kernel.
> Anything else is stupid.
>
OHHH,
good sense at last!!
I was starting to worry

> Handling spaces and newlines is easy enough - see the patches from Al
> Viro, for example.
>
> 		Linus
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

