Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276299AbRI1UjU>; Fri, 28 Sep 2001 16:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276300AbRI1UjK>; Fri, 28 Sep 2001 16:39:10 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:5748 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S276299AbRI1UjE>; Fri, 28 Sep 2001 16:39:04 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
        Padraig Brady <padraig@antefacto.com>, <linux-kernel@vger.kernel.org>
Subject: Re: CPU frequency shifting "problems"
In-Reply-To: <Pine.LNX.4.33.0109280902250.1682-100000@penguin.transmeta.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 28 Sep 2001 14:29:45 -0600
In-Reply-To: <Pine.LNX.4.33.0109280902250.1682-100000@penguin.transmeta.com>
Message-ID: <m11ykr5a9y.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> What does exist is the bus clock (well, a multiple of it, but you get the
> idea), and that one is stable. I bet PCI devices don't like to be randomly
> driven at frequencies "somewhere between 12 and 33MHz" depending on load ;)

I doubt they would like it but it is perfectly legal (PCI spec..) to
vary the pci clock, depending upon load.   


Eric
