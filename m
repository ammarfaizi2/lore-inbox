Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268848AbRIDUEH>; Tue, 4 Sep 2001 16:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268856AbRIDUD4>; Tue, 4 Sep 2001 16:03:56 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:7943 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S268848AbRIDUDl>; Tue, 4 Sep 2001 16:03:41 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrea Arcangeli <andrea@suse.de>, Jan Harkes <jaharkes@cs.cmu.edu>
Subject: Re: page_launder() on 2.4.9/10 issue
Date: Tue, 4 Sep 2001 22:10:42 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
In-Reply-To: <20010904131349.B29711@cs.cmu.edu> <20010904135427.A30503@cs.cmu.edu> <20010904215449.S699@athlon.random>
In-Reply-To: <20010904215449.S699@athlon.random>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010904200348Z16581-32383+3477@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 4, 2001 09:54 pm, Andrea Arcangeli wrote:
> On Tue, Sep 04, 2001 at 01:54:27PM -0400, Jan Harkes wrote:
> > Now for the past _9_ stable kernel releases, page aging hasn't worked
> > at all!! Nobody seems to even have bothered to check. I send in a patch
> 
> All I can say is that I hope you will get your problem fixed with one of
> the next -aa, I incidentally started working on it yesterday. So far
> it's a one thousand diff very far from compiling, so it will grow
> further, but it shouldn't take too long to finish the rewrite. Once
> finished the benchmarks and the reproducible 2.4 deadlocks will tell me
> if I'm right.

Which reproducible deadlocks did you have in mind, and how do I reproduce
them?

--
Daniel
