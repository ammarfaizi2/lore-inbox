Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261458AbSIWOCS>; Mon, 23 Sep 2002 10:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261487AbSIWOCR>; Mon, 23 Sep 2002 10:02:17 -0400
Received: from chaos.analogic.com ([204.178.40.224]:52866 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S261458AbSIWOCR>; Mon, 23 Sep 2002 10:02:17 -0400
Date: Mon, 23 Sep 2002 10:09:21 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Ingo Molnar <mingo@elte.hu>
cc: Erik Andersen <andersen@codepoet.org>, Con Kolivas <conman@kolivas.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] Corrected gcc3.2 v gcc2.95.3 contest results
In-Reply-To: <Pine.LNX.4.44.0209231533570.22336-100000@localhost.localdomain>
Message-ID: <Pine.LNX.3.95.1020923100843.3213B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Sep 2002, Ingo Molnar wrote:

> 
> On Mon, 23 Sep 2002, Richard B. Johnson wrote:
> 
> > > It would sure be nice for this sortof test if there were
> > > some sort of a "flush-all-caches" syscall...
> > 
> > I think all you need to do is reload the code-segment register
> > and you end up flushing caches in ix86.
> 
> i'm pretty sure what was meant was the flushing of the pagecache mainly.
> The state of CPU caches does not really play in these several-minutes
> benchmarks, they are at most a few millisecs worth of CPU time to build.
> 

Okay. Sorry about that.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

