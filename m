Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287681AbSAIPcg>; Wed, 9 Jan 2002 10:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287658AbSAIPcT>; Wed, 9 Jan 2002 10:32:19 -0500
Received: from adsl-62-128-214-206.iomart.com ([62.128.214.206]:21008 "EHLO
	lighthouse.i-a.co.uk") by vger.kernel.org with ESMTP
	id <S287615AbSAIPcP>; Wed, 9 Jan 2002 10:32:15 -0500
Date: Wed, 9 Jan 2002 15:28:23 +0000
From: Andy Jeffries <andy@i-a.co.uk>
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Difficulties in interoperating with Windows
Message-Id: <20020109152823.62f65b7c.andy@i-a.co.uk>
In-Reply-To: <200201091506.JAA16825@tomcat.admin.navo.hpc.mil>
In-Reply-To: <20020109093752.31ae1e79.lkml@andyjeffries.co.uk>
	<200201091506.JAA16825@tomcat.admin.navo.hpc.mil>
Organization: Internet Assist Ltd
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I guess part of it may be that Windows
> > is closed source but as reverse engineering for interoperability is
> > legal in the UK (regardless of what the End User License states), is
> > the problem that it is difficult to read the Assembly easily?
>
> That is not reverse engineering - (at least not MY understanding) - you
> are re-translating a copyrighted work. If the translation back into the
> binary form creates the same binary then you have an exact translation.

But would it?  If you disassemble part/all of Windows and use the code to
understand how it works, then use this to create a specification and write
code to use that specification, there should be no problem?

> You also
> have a lawsuit pending. Otherwise you could just disassemble the entire
> windows OS, claim it as your "re-engineered source", and sell/publish
> it.
>
> This is not legal in most locations.

Correct, but I'm not talking about recompiling Windows and selling it, I'm
talking about decompiling it and using the decompiled source to make Linux
work better with it.  That is completely legal.

> Reverse engineering is taking the published specifications, creating
> software that should function in an equivalent manner.

I disagree with that definition and agree with this one:

First result for a www.google.com search on "definition reverse engineer"

http://whatis.techtarget.com/definition/0,289893,sid9_gci507015,00.html

:Software reverse engineering involves reversing a program's machine code
:(the string of 0s and 1s that are sent to the logic processor) back into
:the source code that it was written in, using program language
statements.:Software reverse engineering is done to retrieve the source
code of a:program because the source code was lost, to study how the
program:performs certain operations, to improve the performance of a
program, to:fix a bug (correct an error in the program when the source
code is not:available), to identify malicious content in a program such as
a virus, or:to adapt a program written for use with one microprocessor
for use with a:differently-designed microprocessor. Reverse engineering
for the sole:purpose of copying or duplicating programs constitutes a
copyright:violation and is illegal. In some cases, the licensed use of
software:specifically prohibits reverse engineering.

> The problem with most M$ software is that the published specifications
> are not complete, access to the inputs are not always available (it is
> ALSO covered> by the proprietary/trade secrets/other restrictions).
> Sometimes the output is not available (at least in some countries - DMCA
> again).

While I agree about proprietary/trade secrets may be a grey area, where
you have the express legal right to reverse engineer a software product
for the purposes of interoperability surely that is final.  As the
contract would have been between Microsoft UK and you (note I'm only
discussing the UK and we don't have an equivalent of the DMCA here)

> > Is there not a project on Linux to convert assembly back to C?   Would
> > this be exceptionally hard?
>
> Not hard - just illegal when using it to disassemble proprietary
> software. Debuggers do this very frequently, to the point that I would
> say "all the time" except for debuggers of interpreted languages.

Depends where you are in the world I guess.  I am specifically (in the UK)
given the right to do this.

Just interested in opinions on this...


--
Andy Jeffries
Head of Web Development
Internet Assist Ltd

Tel : +44 (0)208 547 3700     Fax   : +44 (0)208 547 3600
Web : http://www.i-a.co.uk    Email : andy@i-a.co.uk

"Helping business achieve quality and cost effective Internet Services."

------------------------------------------------------------------------
The information in this message is confidential and is intended for the
addressee only. If you have received this message in error it must be
deleted and the sender notified. The views expressed in this message
are personal and not necessarily those of Internet Assist Ltd unless
explicitly stated.
------------------------------------------------------------------------
