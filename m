Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132915AbRAGOtK>; Sun, 7 Jan 2001 09:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133051AbRAGOsu>; Sun, 7 Jan 2001 09:48:50 -0500
Received: from rumms.uni-mannheim.de ([134.155.50.52]:55437 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id <S132915AbRAGOsm>; Sun, 7 Jan 2001 09:48:42 -0500
Date: Sun, 7 Jan 2001 15:49:13 +0100 (CET)
From: Matthias Juchem <matthias@gandalf.math.uni-mannheim.de>
Reply-To: Matthias Juchem <juchem@uni-mannheim.de>
To: David Ford <david@linux.com>
cc: Alan Cox <alan@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] new bug report script
In-Reply-To: <3A588082.BCE1F971@linux.com>
Message-ID: <Pine.LNX.4.30.0101071545320.7104-100000@gandalf.math.uni-mannheim.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Jan 2001, David Ford wrote:

> > Why can't I assume that perl is installed? It can be found on every
> > standard Linux/Unix installation.
>
> No it can't.  Perl isn't on any of my distributions as part of the standard
> installation.

Ok, I was wrong. I'm used to perl, I've seen perl on every Linux
installation and on almost every Unix installation I've been working
with.

> > My script is intended for the one who likes to provide bug reports but is
> > too lazy to look up all the information or simply is not sure about what
> > to include.
>
> Why can't it be done in sh?

I can be done in sh, surely. I only tried to promote my perl version
because I've done it in perl and nobody told me earlier that perl is not
liked in the kernel tree - and I've seen some perl scripts there.

I guess I'll have to convert the script to sh.


Matthias

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
