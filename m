Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261173AbRERRHi>; Fri, 18 May 2001 13:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261172AbRERRHW>; Fri, 18 May 2001 13:07:22 -0400
Received: from fjordland.nl.linux.org ([131.211.28.101]:53000 "EHLO
	fjordland.nl.linux.org") by vger.kernel.org with ESMTP
	id <S261191AbRERRHH>; Fri, 18 May 2001 13:07:07 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Arjan van de Ven <arjanv@redhat.com>, "Eric S. Raymond" <esr@thyrsus.com>,
        linux-kernel@vger.kernel.org
Subject: Re: CML2 design philosophy heads-up
Date: Fri, 18 May 2001 19:07:36 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <20010518034307.A10784@thyrsus.com> <20010518105353.A13684@thyrsus.com> <3B053B9B.23286E6C@redhat.com>
In-Reply-To: <3B053B9B.23286E6C@redhat.com>
MIME-Version: 1.0
Message-Id: <01051819073604.00491@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 18 May 2001 17:11, Arjan van de Ven wrote:
> >    (a) Back off the capability approach.  That is, accept that
> >        people doing configuration are going to explicitly and
> >        exhaustively specify low-level hardware.
>
> <snip>
>
> > I don't want to do (a); it conflicts with my design objective of
> > simplifying configuration enough that Aunt Tillie can do it.  I
> > won't do that unless I see a strong consensus that it's the only
> > Right Thing.
>
> Aunt Tillie doesn't even know what a kernel is, nor does she want to.

A little presumptuous, no?  I do in fact know an 'Aunt Tillie' type who
configures her own kernel.  When she gets stuck she calls for help from
her son, who is a computer geek.

> I think it's fair to assume that people who configure and compile their own
> kernel (as opposed to using the distribution supplied ones) know what they
> are doing.

Not a fair assumption, if only because everybody does it for the first 
time.

> Or at least make something like a "Expert level" question as first question, so
> that people who DO know what they are doing can select the options they want.

Yes.  The hackneyed platitude that 'easy' and 'powerful' are mutually 
exclusive is a statistical observation, not a law of the universe.

--
Daniel
