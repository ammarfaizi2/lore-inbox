Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136058AbRD0OnI>; Fri, 27 Apr 2001 10:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136059AbRD0Oms>; Fri, 27 Apr 2001 10:42:48 -0400
Received: from www.wen-online.de ([212.223.88.39]:48913 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S136058AbRD0Omq>;
	Fri, 27 Apr 2001 10:42:46 -0400
Date: Fri, 27 Apr 2001 16:41:21 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Rik van Riel <riel@conectiva.com.br>, Ingo Molnar <mingo@elte.hu>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] swap-speedup-2.4.3-B3 (fwd)
In-Reply-To: <Pine.LNX.4.21.0104270844560.2863-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0104271639550.310-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Apr 2001, Marcelo Tosatti wrote:

> On Fri, 27 Apr 2001, Mike Galbraith wrote:
>
> > I decided to take a break from pondering input and see why the thing
> > ran itself into the ground.  Methinks I was sent the wrooong patch :)
>
> Mike,
>
> Please apply this patch on top of Rik's v2 patch otherwise you'll get the
> livelock easily:

test results:

real    11m44.088s
user    7m57.720s
sys     0m36.420s

