Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261395AbVCaMse@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261395AbVCaMse (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 07:48:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261412AbVCaMse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 07:48:34 -0500
Received: from alog0015.analogic.com ([208.224.220.30]:43411 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261395AbVCaMs1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 07:48:27 -0500
Date: Thu, 31 Mar 2005 07:34:46 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Sean <seanlkml@sympatico.ca>
cc: Rik van Riel <riel@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
       Kyle Moffett <mrmacman_g4@mac.com>, floam@sh.nu,
       LKML <linux-kernel@vger.kernel.org>, arjan@infradead.org,
       Paul Jackson <pj@engr.sgi.com>, gilbertd@treblig.org,
       vonbrand@inf.utfsm.cl, bunk@stusta.de
Subject: Re: Can't use SYSFS for "Proprietry" driver modules !!!.
In-Reply-To: <3343.10.10.10.24.1112268948.squirrel@linux1.attic.local>
Message-ID: <Pine.LNX.4.61.0503310706280.8616@chaos.analogic.com>
References: <200503280154.j2S1s9e6009981@laptop11.inf.utfsm.cl>   
 <1112011441.27381.31.camel@localhost.localdomain>   
 <1112016850.6003.13.camel@laptopd505.fenrus.org>   
 <1112018265.27381.63.camel@localhost.localdomain>    <20050328154338.753f27e3.pj@engr.sgi.com>
    <1112055671.3691.8.camel@localhost.localdomain>   
 <c4ce304162b3d2a3ad78dc9e0bc455f5@mac.com>    <1112059642.3691.15.camel@localhost.localdomain>
    <Pine.LNX.4.61.0503290659360.10929@chaos.analogic.com>   
 <Pine.LNX.4.61.0503301446430.30163@chimarrao.boston.redhat.com>   
 <Pine.LNX.4.61.0503301455570.28630@chaos.analogic.com>
 <3343.10.10.10.24.1112268948.squirrel@linux1.attic.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Mar 2005, Sean wrote:

> On Wed, March 30, 2005 2:57 pm, linux-os said:
>
>> Yes. And this would show that whomever did that already violated the
>> intent of the GPL by adding restrictions to use. NotGood(tm).
>
> Dick,
>
> You are so full of shit.  There are no additonal restrictions, just the
> restrictions of the GPL; period.   Adding _GPL to the symbol does not
> place any additional restriction on the people who are already bound by
> the GPL.

Sure it does. Before the GPL-only stuff the only problem one would
have with a proprietary module, i.e., one that didn't contain
the GPL "license" notice, was that the kernel would be marked
"tainted". Everything would still work.

With the ADDITIONAL RESTRICTION added, the module won't even work
because an ARTIFICIAL CONSTRAINT was added to prevent its use
unless a GPL "license" notice existed.


> You were much easier to endure when you were just pretending to
> have invented RLE.
>

No pretense, and the original implementation, used under CP/M for
*.LBQ files, given to the world through my PROGRAM EXCHANGE
BBS in 1980, long before there was any GPL, was a much better
implementation than what became known as "RLL" when the disc-
drive people got ahold of it. For those, not in their '60s,
*.LBQ was the early precursor to Phil Katz's *.ZIP files.
He wasn't able to take the heat of all the people who kept
putting him down. He died an early death. I'm going to
outlast all you nay-sayers because when you write facts,
you don't have to remember what you previously wrote so
the liars can't hurt you.

You see, with the original idea of free software, it was free.
You were expected to leave any copyright notice alone. This
free software idea was picked up by UC Berkeley once the
Internet took hold.

The rest is history about a neat idea that became corrupted,
first by the likes of Stallman, then by others when it became
a religion.

> Sean
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
