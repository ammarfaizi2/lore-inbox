Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289767AbSBNLBx>; Thu, 14 Feb 2002 06:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291423AbSBNLBo>; Thu, 14 Feb 2002 06:01:44 -0500
Received: from mail49-s.fg.online.no ([148.122.161.49]:59596 "EHLO
	mail49.fg.online.no") by vger.kernel.org with ESMTP
	id <S289767AbSBNLB0>; Thu, 14 Feb 2002 06:01:26 -0500
To: Rob Landley <landley@trommello.org>
Cc: Aaron Lehmann <aaronl@vitelus.com>, Jeff Garzik <jgarzik@mandrakesoft.com>,
        Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org
Subject: Re: ssh primer (was Re: pull vs push (was Re: [bk patch] Make
 cardbus compile in -pre4))
In-Reply-To: <E16ZhzF-0000ST-00@gondolin.me.apana.org.au>
	<3C65CBDE.A9B60BBD@mandrakesoft.com>
	<20020213171306.GA15924@vitelus.com>
	<20020214002205.VBHJ21911.femail34.sdc1.sfba.home.com@there>
From: Harald Arnesen <gurre@start.no>
Date: Thu, 14 Feb 2002 12:00:03 +0100
In-Reply-To: <20020214002205.VBHJ21911.femail34.sdc1.sfba.home.com@there> (Rob
 Landley's message of "Wed, 13 Feb 2002 19:22:57 -0500")
Message-ID: <871yfogwgc.fsf@basilikum.skogtun.org>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) Emacs/21.1
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley <landley@trommello.org> writes:

> Not that it's worth it. Keys get exponentially more difficult to
> brute force as the key length increases. I read part of a book a
> long time ago (might have been called "applied cryptography") that
> figured out that if you could build a perfectly efficient computer
> that could do 1 bit's worth of calculation with the the amount of
> energy in the minimal electron state transition in a hydrogen atom,
> and you built a dyson sphere around the sun to capture its entire
> energy output for the however many billion years its expected to
> last, you wouldn't even brute-force exhaust a relatively small
> keyspace (128 bits? 256 bits? Something like that).
>
> Somebody else here is likely to recognize the above anecdote and give a more 
> accurate reference.  Book title and page number would be good...

Bruce Schneier's "Applied Cryptography" (second edition, may be in the
first edition as well), pages 157-158 ("Thermodynamic Limitations").
-- 
Hilsen Harald.
