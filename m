Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313293AbSERQV5>; Sat, 18 May 2002 12:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313307AbSERQV4>; Sat, 18 May 2002 12:21:56 -0400
Received: from stout.engsoc.carleton.ca ([134.117.69.22]:32132 "EHLO
	stout.engsoc.carleton.ca") by vger.kernel.org with ESMTP
	id <S313293AbSERQVz>; Sat, 18 May 2002 12:21:55 -0400
Date: Sat, 18 May 2002 12:21:37 -0400 (EDT)
From: Paul Faure <paul@engsoc.org>
X-X-Sender: <paul@lager.engsoc.carleton.ca>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@zip.com.au>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Process priority in 2.4.18 (RedHat 7.3)
In-Reply-To: <E178lM7-0006uZ-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0205181220150.16528-100000@lager.engsoc.carleton.ca>
X-Home-Page: http://www.engsoc.org/
X-URL: http://www.engsoc.org/
Organisation: Engsoc Project (www.engsoc.org)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My brother dropped of a network card (smc-ultra) and it works fine with 
the 2.4.18-4 redhat kernel. If you are still interested in testing the 
ne.o card with the latest official kernel, I can do so.

Thanks for all your help.

On Fri, 17 May 2002, Alan Cox wrote:

> > hmm, tiny != burst. of course sometime ksoftirqd will kick in when it
> > notices a burst. But it is irrelevant to this thread about SCHED_FIFO +
> > ksoftirqd.
> 
> Agreed
> 
> > If there's SCHED_FIFO app in loop, ksoftirqd never runs and we only rely
> > on the support from irq that we had in 2.4.0 and previous too.
> 
> Yes
> 

-- 
Paul N. Faure					613.266.3286
EngSoc Administrator            		paul-at-engsoc-dot-org
Chief Technical Officer, CertainKey Inc.	paul-at-certainkey-dot-com
Carleton University Systems Eng. 4th Year	paul-at-faure-dot-ca

