Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277720AbRJROBa>; Thu, 18 Oct 2001 10:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277718AbRJROBW>; Thu, 18 Oct 2001 10:01:22 -0400
Received: from chaos.analogic.com ([204.178.40.224]:43905 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S277717AbRJROBQ>; Thu, 18 Oct 2001 10:01:16 -0400
Date: Thu, 18 Oct 2001 09:58:33 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Adrian Bunk <bunk@fs.tum.de>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Non-GPL modules
In-Reply-To: <Pine.NEB.4.40.0110181529400.1110-100000@mimas.fachschaften.tu-muenchen.de>
Message-ID: <Pine.LNX.3.95.1011018094613.431A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Oct 2001, Adrian Bunk wrote:

> On Thu, 18 Oct 2001, Richard B. Johnson wrote:
> 
> >...
> > In the business world, something as simple as puts("Hello World!");
> > MUST be kept a trade secret. If it was written by an employee
> > in the context of his or her job, the company's stockholders owns
> > that line of code so no employee, even the President, is allowed
> > to give it away.
> >...
> 
> IOW: Companies like IBM, SAP, Sun and SGI that made code available under
> the GPL (e.g. as part of the linux kernel or with of relicensed programs)
> weren't allowed to do this???
> 
> 
> Am I allowed to consider this a bad joke?
> 
> 

It's no joke. Some companies require, in the process of producing
goods and services, that certain interface code and documentation
be provided. For instance, if I make an Ethernet card, it's in
the best interest of the company to sell as many boards as possible.
Therefore, certain information must be given away to obtain those
goals. So, I would provide register-level documentation, sample
source-code, and maybe even drivers for the majority of the known
Operating Systems.

However, If my company makes Bomb Scanners (it does), I cannot
divulge to potential adversaries, either the competition or potential
bombers, how it works. It's just that simple.

If your end product is a board that plugs into a PC, you have a
different set of rules than if your end product is a Bomb Scanner,
a Flight Management System, or a Numerical Milling Machine.
Basically, embedded stuff, both hardware and software, remains hidden.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


