Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310379AbSCAH4i>; Fri, 1 Mar 2002 02:56:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310385AbSCAHw3>; Fri, 1 Mar 2002 02:52:29 -0500
Received: from mailout11.sul.t-online.com ([194.25.134.85]:42393 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S310377AbSCAHsv>; Fri, 1 Mar 2002 02:48:51 -0500
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: nfs-devel@linux.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.5: compile error in fs/filesystems.c
In-Reply-To: <87vgchi2v8.fsf@tigram.bogus.local>
	<15486.50159.606621.827886@notabene.cse.unsw.edu.au>
	<87bse9hzok.fsf@tigram.bogus.local>
	<15486.54383.958359.357643@notabene.cse.unsw.edu.au>
From: Olaf Dietsche <olaf.dietsche--list.linux-kernel@exmail.de>
Date: Fri, 01 Mar 2002 08:48:30 +0100
In-Reply-To: <15486.54383.958359.357643@notabene.cse.unsw.edu.au> (Neil
 Brown's message of "Fri, 1 Mar 2002 12:07:59 +1100 (EST)")
Message-ID: <87664giv8x.fsf@tigram.bogus.local>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) XEmacs/21.4 (Artificial
 Intelligence, i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

Neil Brown <neilb@cse.unsw.edu.au> writes:

> There have been a number of problem reports on linux-kernel over the
> last year or two from people who cannot load nfsd.o as a module.
> Often it is because they originally compiled without and NFSD support
> at all, but subsequently decided that wanted to compile and load
> nfsd.o
>
> This works for many modules (e.g. filesystems)  It is reasonable that
> it work for nfsd as well.
>
> I thought that the cost of always including the hooks to load nfsd was
> minimal, and worth the consistency/convenience.
>
> Does that seem reasonable to you?

Ok, I didn't think of that. Thanks for clarifying.

Regards, Olaf.
