Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135209AbRDZIjZ>; Thu, 26 Apr 2001 04:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135210AbRDZIjP>; Thu, 26 Apr 2001 04:39:15 -0400
Received: from chiara.elte.hu ([157.181.150.200]:24078 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S135209AbRDZIjE>;
	Thu, 26 Apr 2001 04:39:04 -0400
Date: Thu, 26 Apr 2001 09:37:39 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] swap-speedup-2.4.3-B3 (fwd)
In-Reply-To: <Pine.LNX.4.33.0104260617020.566-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.30.0104260934520.1198-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 26 Apr 2001, Mike Galbraith wrote:

> More of a question.  Neither Ingo's nor your patch makes any
> difference on my UP box (128mb PIII/500) doing make -j30. [...]

(the patch Marcelo sent is the -B3 patch plus Linus' suggested async
interface cleanup, so it should be functionally equivalent to the -B3
patch.)

	Ingo

