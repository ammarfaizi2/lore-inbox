Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268769AbTBZPJr>; Wed, 26 Feb 2003 10:09:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268771AbTBZPJr>; Wed, 26 Feb 2003 10:09:47 -0500
Received: from chaos.analogic.com ([204.178.40.224]:54912 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S268769AbTBZPJq>; Wed, 26 Feb 2003 10:09:46 -0500
Date: Wed, 26 Feb 2003 10:21:32 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Steven Cole <elenstev@mesatop.com>
cc: vda@port.imtp.ilyichevsk.odessa.ua, Michael Hayes <mike@aiinc.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [REVISED][PATCH] Spelling fixes for 2.5.63 - can't
In-Reply-To: <1046271385.6615.174.camel@spc9.esa.lanl.gov>
Message-ID: <Pine.LNX.3.95.1030226100843.3747A-100000@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 Feb 2003, Steven Cole wrote:

> On Tue, 2003-02-25 at 23:12, Denis Vlasenko wrote:
> > On 26 February 2003 00:48, Michael Hayes wrote:
> > > Removed changes to comments in .S files -- gcc does not like
> > > apostrophes in assembler comments.
> > >
> > > This fixes:
> > >     cant -> can't (28 occurrences)
> > 
> > Some editors which do syntax highlighting have bugs
> > and treat ' like string delimiter even in comments.
> > I usually "fix" it by removing apostrophes from
> > "can't" ;)
> > --
> > vda
> 
> Sounds like time for a better editor. ;)
> 
> A better fix for you might be s/can't/cannot/g.
> 
> Steven
> 
> -

Sounds like gcc should get fixed. I once used a so-called 'C'
compiler which would barf if it found '%' anywhere, not
in quotes.

The so-called meta-char was used to "expand macros" that
were compiler-specific. I contacted the company, Intermetrics,
and they called it a feature. Strangely, they are still in
business, recently awarded a 3 million software contract by
NASA for "spacelink". Go figure. They probably have fixed their
crap by now because NASA isn't that dumb. GCC should probably
do the same.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


