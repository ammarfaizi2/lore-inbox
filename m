Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284676AbRL3Twa>; Sun, 30 Dec 2001 14:52:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284687AbRL3TwV>; Sun, 30 Dec 2001 14:52:21 -0500
Received: from svr3.applink.net ([206.50.88.3]:43789 "EHLO svr3.applink.net")
	by vger.kernel.org with ESMTP id <S284676AbRL3TwH>;
	Sun, 30 Dec 2001 14:52:07 -0500
Message-Id: <200112301951.fBUJoxSr011753@svr3.applink.net>
Content-Type: text/plain; charset=US-ASCII
From: Timothy Covell <timothy.covell@ashavan.org>
Reply-To: timothy.covell@ashavan.org
To: Stephan von Krawczynski <skraw@ithnet.com>,
        Davide Libenzi <davidel@xmailserver.org>
Subject: Re: [PATCH] Balanced Multi Queue Scheduler ...
Date: Sun, 30 Dec 2001 13:47:09 -0600
X-Mailer: KMail [version 1.3.2]
Cc: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Robert Love <rml@tech9.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <200112292338.AAA29985@webserver.ithnet.com>
In-Reply-To: <200112292338.AAA29985@webserver.ithnet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 29 December 2001 17:38, Stephan von Krawczynski wrote:
[snip]
> We cannot deny the fact that people expect the scalability of the
> system, and just to give you a small hint, I personally already
> stopped buying UP machines. There is no real big difference in prices
> between UP and 2-SMP these days, and RAM is unbelievably cheap in this
> decade - and it makes your seti-statistics fly ;-)

Ummm, on my Dual P-III (650MHz with 524988416 Bytes), my current Seti 
efficiency is 5.35 CpF.   That's a tad high/slower than an Ultra Sparc IIi 
according to their stats.  So, it would appear that being SMP is hurting my 
performance a bit.   Unless that is that you meant to run a seti instance for 
each CPU?   And this reminds me of how "make -j3 bzlilo" is slower than
"make -j2 bzlilo".

> So these issues will be very much in the mainstream of all users. No
> way to deny this.
> I have no fear: this is a reachable goal, let's just take it.
>
> Regards,
> Stephan
>
> PS: Yes, Alan, I read your mail about the 32GB box and DMA and stuff,
> but nevertheless we should keep up with the market-ongoings (damn
> cheap 1GB modules).
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
timothy.covell@ashavan.org.
