Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318992AbSHMNxu>; Tue, 13 Aug 2002 09:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319011AbSHMNxu>; Tue, 13 Aug 2002 09:53:50 -0400
Received: from romulus.cs.ut.ee ([193.40.5.125]:29326 "EHLO romulus.cs.ut.ee")
	by vger.kernel.org with ESMTP id <S318992AbSHMNxt>;
	Tue, 13 Aug 2002 09:53:49 -0400
Date: Tue, 13 Aug 2002 16:57:37 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux TCP problem while talking to hostme.bkbits.net ?
In-Reply-To: <200208131340.RAA20981@sex.inr.ac.ru>
Message-ID: <Pine.GSO.4.43.0208131654480.4991-100000@romulus.cs.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> :-) Hey, if we are not going to finish in lunatic asylum we need to do
> something constructive yet. Please, find the place where the packet is dropped.

It does not occur any more since reboot. Will try some printk's and
recompile and wait it to happen _if_ it ever happens again.

Since it's gone now I currently suspect bad RAM the most. But no other
stange thing have happene so I don't really know.

> I do not understand what happens at all. It is surely not a plain
> packet corruption because tcpdump shows correct packet. Hmm... of course,
> provided you make tcpdump on receiving host.

Yes, they were from the receiving host.

-- 
Meelis Roos (mroos@linux.ee)

