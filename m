Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272454AbRIFLSs>; Thu, 6 Sep 2001 07:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272451AbRIFLSj>; Thu, 6 Sep 2001 07:18:39 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:7697 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S272450AbRIFLS0>;
	Thu, 6 Sep 2001 07:18:26 -0400
Date: Thu, 6 Sep 2001 08:18:40 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Jan Harkes <jaharkes@cs.cmu.edu>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        <linux-kernel@vger.kernel.org>
Subject: Re: page_launder() on 2.4.9/10 issue
In-Reply-To: <20010904215449.S699@athlon.random>
Message-ID: <Pine.LNX.4.33L.0109060817370.31200-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Sep 2001, Andrea Arcangeli wrote:
> On Tue, Sep 04, 2001 at 01:54:27PM -0400, Jan Harkes wrote:
> > Now for the past _9_ stable kernel releases, page aging hasn't worked
> > at all!! Nobody seems to even have bothered to check. I send in a patch
>
> All I can say is that I hope you will get your problem fixed with one
> of the next -aa, I incidentally started working on it yesterday.

You too? ;)

> So far it's a one thousand diff very far from compiling, so it will
> grow further, but it shouldn't take too long to finish the rewrite.
> Once finished the benchmarks and the reproducible 2.4 deadlocks will
> tell me if I'm right.

Of course, we could try to work together on this one, since
we both seem to be starved for time ...

cheers,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

