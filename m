Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135220AbRDZIyG>; Thu, 26 Apr 2001 04:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135217AbRDZIxz>; Thu, 26 Apr 2001 04:53:55 -0400
Received: from www.wen-online.de ([212.223.88.39]:25103 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S135216AbRDZIxl>;
	Thu, 26 Apr 2001 04:53:41 -0400
Date: Thu, 26 Apr 2001 10:53:06 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Ingo Molnar <mingo@elte.hu>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] swap-speedup-2.4.3-B3 (fwd)
In-Reply-To: <Pine.LNX.4.30.0104260934520.1198-100000@elte.hu>
Message-ID: <Pine.LNX.4.33.0104261051320.378-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Apr 2001, Ingo Molnar wrote:

>
> On Thu, 26 Apr 2001, Mike Galbraith wrote:
>
> > More of a question.  Neither Ingo's nor your patch makes any
> > difference on my UP box (128mb PIII/500) doing make -j30. [...]
>
> (the patch Marcelo sent is the -B3 patch plus Linus' suggested async
> interface cleanup, so it should be functionally equivalent to the -B3
> patch.)
>
> 	Ingo

I know.. read 'em all with much interest :)

	-Mike

