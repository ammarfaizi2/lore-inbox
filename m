Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276318AbRJPOEt>; Tue, 16 Oct 2001 10:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276329AbRJPOEj>; Tue, 16 Oct 2001 10:04:39 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:65286 "EHLO
	deathstar.prodigy.com") by vger.kernel.org with ESMTP
	id <S276318AbRJPOEX>; Tue, 16 Oct 2001 10:04:23 -0400
Date: Tue, 16 Oct 2001 10:04:50 -0400
Message-Id: <200110161404.f9GE4oZ01317@deathstar.prodigy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: VM
X-Newsgroups: linux.dev.kernel
In-Reply-To: <Pine.LNX.4.33.0110161503300.17096-100000@Expansa.sns.it>
Organization: TMR Associates, Schenectady NY
From: davidsen@tmr.com (bill davidsen)
Reply-To: davidsen@tmr.com (bill davidsen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.33.0110161503300.17096-100000@Expansa.sns.it> 
	kernel@Expansa.sns.it wrote:
>I used bot VM in many situations and with many different HWs.
>I came to the conclusion that  actually  none of the two VMs is suitable
>for every use.
>aa VM deals better because of its design on my web servers, with a non
>eccessive amount of memory, and with mysql and oracle databases.


>I do not care which VM is simpler, nor which is faster. I loock for
>predictability, since this is the most important thing on the servers I am
>administering. Under a special situation I need something maybe less
>predictable, but smarter to manage a stressed system.
>
>80%... 5%... I do not care for exact numbers actually, I will care in
>future, if the situation comes to the point that both VMs will be quite
>good for everything. anyway it is a good strategy to follow two different
>way, since they are progressing quite welll together, with competition,
>and also (I hope) reciprocal help (just to be able to read the code of the
>other is a good help:) ).

Very well said. And I might add that some input from people with small
desktop machines might be useful to the developers, since I doubt they
are running small slow machines. While I wouldn't compromise big memory
performance (much) for small, one beauty of Linux is that it will run
well on small machines.

Of course it may be that some other VM will prove to be bnetter than
either, but hopefully not until 2.5. I'd still like to see VM in a
module and then everyone could play with their pet theory;-)

-- 
bill davidsen <davidsen@tmr.com>
 "If I were a diplomat, in the best case I'd go hungry.  In the worst
  case, people would die."
		-- Robert Lipe
