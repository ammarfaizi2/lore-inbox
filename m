Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265169AbSLVTZC>; Sun, 22 Dec 2002 14:25:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265171AbSLVTZC>; Sun, 22 Dec 2002 14:25:02 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:40968 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265169AbSLVTZB>; Sun, 22 Dec 2002 14:25:01 -0500
Date: Sun, 22 Dec 2002 11:34:06 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ulrich Drepper <drepper@redhat.com>
cc: "James H. Cloos Jr." <cloos@jhcloos.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <3E060D8B.5060208@redhat.com>
Message-ID: <Pine.LNX.4.44.0212221132370.2692-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 22 Dec 2002, Ulrich Drepper wrote:
>
> It is already available.  I've announced it on the NPTL mailing list a
> couple of days ago.

Ok. I was definitely thinking of something rpm-like, since I know building
it is a bitch, and doing things wrong tends to result in systems that
don't work all that well.

> If there is interest in RPMs of the binaries I might _try_ to provide
> some.  But this would mean replacing the system's libc.

I suspect that many people who test out 2.5.x kernels (and especially -bk
snapshots) don't find that too scary.

		Linus

