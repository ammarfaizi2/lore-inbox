Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319048AbSHMWLH>; Tue, 13 Aug 2002 18:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319060AbSHMWLG>; Tue, 13 Aug 2002 18:11:06 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:48394 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S319048AbSHMWLF>; Tue, 13 Aug 2002 18:11:05 -0400
Date: Tue, 13 Aug 2002 19:14:45 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Matt Dobson <colpatch@us.ibm.com>
Subject: Re: [PATCH] NUMA-Q disable irqbalance
In-Reply-To: <Pine.LNX.4.44L.0208131908071.23404-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.44L.0208131913400.23404-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Aug 2002, Rik van Riel wrote:
> On Tue, 13 Aug 2002, Linus Torvalds wrote:

> > Hmm. And I could _feel_ how my dual HT P4 was slow before the irq issues
> > were fixed.
>
> "If you can't measure it, it doesn't exist"
>
> *runs like hell*

As a clarification to this, I'm not suggesting that interactive
performance doesn't exist, I'm suggesting that we should measure
it.

I've got a few rough ideas on how to measure these things and
will send out a few benchmark proposals shortly.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

