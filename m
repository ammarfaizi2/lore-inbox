Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284953AbRLFDSE>; Wed, 5 Dec 2001 22:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284957AbRLFDRx>; Wed, 5 Dec 2001 22:17:53 -0500
Received: from sydney1.au.ibm.com ([202.135.142.193]:45067 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S284953AbRLFDRg>; Wed, 5 Dec 2001 22:17:36 -0500
Date: Thu, 6 Dec 2001 14:18:26 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@zip.com.au>
Cc: riel@conectiva.com.br, kiran@in.ibm.com, lse-tech@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] Scalable Statistics Counters
Message-Id: <20011206141826.16833acc.rusty@rustcorp.com.au>
In-Reply-To: <3C0E7ED9.1F0BD44E@zip.com.au>
In-Reply-To: <20011205163153.E16315@in.ibm.com>
	<Pine.LNX.4.33L.0112051109340.4079-100000@imladris.surriel.com>
	<3C0E7ED9.1F0BD44E@zip.com.au>
X-Mailer: Sylpheed version 0.6.3 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Dec 2001 12:08:57 -0800
Andrew Morton <akpm@zip.com.au> wrote:

> Rik van Riel wrote:
> > 
> > (it'd be so cool if we could just start using a statistic variable
> > through some macro and it'd be automatically declared and visible
> > in /proc ;))
> > 
> 
> Marcelo and I worked out a thing which did that a while back.
> 
> http://www.zipworld.com.au/~akpm/linux/2.4/2.4.7/

Oops, guess I should have read this thread first (still catching up on mail).

Please see my per-cpu patch (just posted under [PATCH] 2.5.1-pre5: per-cpu
areas), and my previous /proc patch.  Combining the two into convenient form
is left as an exercise for the reader...

Cheers!
Rusty.
-- 
  Anyone who quotes me is an idiot. -- Rusty Russell.
