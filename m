Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319000AbSHMRfs>; Tue, 13 Aug 2002 13:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319001AbSHMRfs>; Tue, 13 Aug 2002 13:35:48 -0400
Received: from chaos.analogic.com ([204.178.40.224]:47499 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S319000AbSHMRfr>; Tue, 13 Aug 2002 13:35:47 -0400
Date: Tue, 13 Aug 2002 13:42:19 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Christoph Hellwig <hch@infradead.org>
cc: Erik Andersen <andersen@codepoet.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] clone_startup(), 2.5.31-A0
In-Reply-To: <20020813171138.A12546@infradead.org>
Message-ID: <Pine.LNX.3.95.1020813134155.22318A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Aug 2002, Christoph Hellwig wrote:

> On Tue, Aug 13, 2002 at 10:09:24AM -0600, Erik Andersen wrote:
> > > First the name souns horrible.  What about spawn_thread or create_thread
> > > instead?  it's not our good old clone and not a lookalike, it's some
> > > pthreadish monster..
> > 
> > How about "clone2"?
> 
> Already used by ia64 for a hybrid between the good old clone and the new
> monster :)
> 
> And as I said again, it doesn't really clone - it starts something
> different, namely the fn argument.
> 

fn_startup()

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

