Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266528AbRGLTSc>; Thu, 12 Jul 2001 15:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266536AbRGLTSW>; Thu, 12 Jul 2001 15:18:22 -0400
Received: from www.wen-online.de ([212.223.88.39]:1799 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S266528AbRGLTSL>;
	Thu, 12 Jul 2001 15:18:11 -0400
Date: Thu, 12 Jul 2001 21:17:23 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Dirk Wetter <dirkw@rentec.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: dead *man* pages ;-)
In-Reply-To: <Pine.LNX.4.33.0107121057100.30412-100000@monster000.rentec.com>
Message-ID: <Pine.LNX.4.33.0107122109350.504-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jul 2001, Dirk Wetter wrote:

> Hi Mike,
>
> On Thu, 12 Jul 2001, Mike Galbraith wrote:
>
> > > don't wanna be offensive, but: in my case it IS swapping heavily. if
> > > somebody dares to reply again to me, that it's not, i am cordially invite
> > > him/her to read my emails more thouroughly before i get a reply
> > > like "it is not swapping, it is only appear to be swapping".
> >
> > Your heads aren't _really_ rattling, they only _sound_ like..  ;-)
>
> well, we are living in a world of fake and fraud. ;-)

'Twas a joke 'course.

> > Have you had a chance to try 2.4.7-pre-latest yet?  I'd be interested
> > in a small sample of vmstat 1 leading into heavy swap with >=pre5 if
> > it is still a problem.
>
> i will definetely check it out and give a report, since the test i did
> yesterday the *command* "vmstat 1" in typed in appeared to be :)) more
> like "vmstat 180", no kidding.

Ok, you have some 'io bound' issues that need to be looked at.  Present
the data in that light please.

	-Mike

