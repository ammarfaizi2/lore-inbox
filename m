Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265725AbSLJURA>; Tue, 10 Dec 2002 15:17:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266199AbSLJURA>; Tue, 10 Dec 2002 15:17:00 -0500
Received: from c16688.thoms1.vic.optusnet.com.au ([210.49.244.54]:465 "EHLO
	mail.kolivas.net") by vger.kernel.org with ESMTP id <S265725AbSLJUQ7>;
	Tue, 10 Dec 2002 15:16:59 -0500
Message-ID: <1039551880.3df64d88dc470@kolivas.net>
Date: Wed, 11 Dec 2002 07:24:40 +1100
From: Con Kolivas <conman@kolivas.net>
To: Stan Bubrouski <stan@ccs.neu.edu>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] 2.5.51 with contest
References: <200212102245.19862.conman@kolivas.net> <3DF621D0.6040505@ccs.neu.edu>
In-Reply-To: <3DF621D0.6040505@ccs.neu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stan Bubrouski <stan@ccs.neu.edu>:

> Con Kolivas wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> > 
> > Here are contest results (http://contest.kolivas.net) for 2.5.51 and
> related 
> > kerneles using the dedicated osdl (http://www.osdl.org) hardware. 
> > 
> > Uniprocessor:
> > noload:
> > Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> > 2.5.49 [5]              70.0    96      0       0       1.05
> > 2.5.50 [5]              69.9    96      0       0       1.05
> > 2.5.50-mm1 [5]          71.4    94      0       0       1.07
> > 2.5.51 [2]              69.8    96      0       0       1.05
> 
> I know this has been brought up before, but
> these don't seem to mean much unless you
> include 2.4.20 in the comaprison.

Repeated benchmarks of each successive release allow to detect subtle
differences of each change. If contest shows these changes the people who can
act on them will see them clearly if displayed only with relevant results. If
you want previous results, a full comparison is available at the full logs of
all previous benchmarks as I mention.

http://www.osdl.org/projects/ctdevel/results/

Con
