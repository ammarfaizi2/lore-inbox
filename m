Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264743AbSLQGMS>; Tue, 17 Dec 2002 01:12:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264748AbSLQGMS>; Tue, 17 Dec 2002 01:12:18 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:37896 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S264743AbSLQGMQ>; Tue, 17 Dec 2002 01:12:16 -0500
Message-Id: <200212170614.gBH6ELs15888@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: "J.A. Magallon" <jamagallon@able.es>,
       Scott Robert Ladd <scott@coyotegulch.com>
Subject: Re: HT Benchmarks (was: /proc/cpuinfo and hyperthreading)
Date: Tue, 17 Dec 2002 09:03:38 -0200
X-Mailer: KMail [version 1.3.2]
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <FKEAJLBKJCGBDJJIPJLJAEOLDLAA.scott@coyotegulch.com> <20021216232755.GA3750@werewolf.able.es>
In-Reply-To: <20021216232755.GA3750@werewolf.able.es>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 December 2002 21:27, J.A. Magallon wrote:
> On 2002.12.17 Scott Robert Ladd wrote:
> [...]
>
> From what I can see, HT provides a 0-15% increase in performance,
> depending
>
> >heavily on the type of code being run. In other words, HT helps, but
> > it is *no* substitute for true multiple processors. And it is ONLY
> > of value when an SMP kernel is in use.
>
> What I don't like is that Intel sells it like the best thing since
> sliced bread, and get a money for it, see the price of Xeons compared
> to normal P4s...

What did you expect? They are making processors for money, and have
to push the sales.

As to HT, it's definitely a good thing. Multiple CPUs on a chip is
a logical step. HT in P4 is rather weak, but future processors will
likely have more advanced cores.

I never heard about HT from AMD camp. I'm curious what they do. ;)
--
vda
