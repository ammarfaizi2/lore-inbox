Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264272AbTFISrK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 14:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264380AbTFISrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 14:47:10 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:138 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S264272AbTFISrH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 14:47:07 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 9 Jun 2003 11:58:43 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Timothy Miller <miller@techsource.com>
cc: =?X-UNKNOWN?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Coding standards.  (Was: Re: [PATCH] [2.5] Non-blocking write
 can block)
In-Reply-To: <3EE4D80A.2050402@techsource.com>
Message-ID: <Pine.LNX.4.55.0306091142420.3614@bigblue.dev.mcafeelabs.com>
References: <Pine.HPX.4.33L.0306040144400.8930-100000@punch.eng.cam.ac.uk>
 <20030604065336.A7755@infradead.org> <3EDE0E85.7090601@techsource.com>
 <20030607001202.GB14475@kroah.com> <3EE4B4C3.80902@techsource.com>
 <20030609163959.GA13811@wohnheim.fh-wedel.de>
 <Pine.LNX.4.55.0306091001270.3614@bigblue.dev.mcafeelabs.com>
 <3EE4D80A.2050402@techsource.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jun 2003, Timothy Miller wrote:

> > There's no such a thing as "horrible coding style", since coding style is
> > strictly personal. Whoever try to convince you that one style is better
> > than another one is simply plain wrong. Every reason they will give you to
> > justify one style can be wiped with other opposite reasons. The only
> > horrible coding style is to not respect coding standards when you work
> > inside a project. This is a form of respect for other people working
> > inside the project itself, give the project code a more professional
> > look and lower the fatigue of reading the project code. Jumping from 24
> > different coding styles does not usually help this. I do not believe
> > professional developers can be scared by a coding style, if this is the
> > coding style adopted by the project where they have to work in.
>
> Oh, yes, there is most certainly "horrible coding style".  When I was in
> college, I met one CS student after another who really just did not
> belong in CS, and you should have seen the code they wrote.


> On Mon, 9 June 2003 11:07:32 -0700, Davide Libenzi wrote:
> >
> > You know why the code you reported is *wrong* (besides from how
> > techincally do things) ? Mixing lower and upper case, using long variable
> > and function names, etc... are simply a matter of personal taste and you
> > cannot say that such code is "absolutely" wrong. The code is damn wrong
> > because it violates about 25 sections of the project's defined CodingStyle
> > document, that's why it is wrong.
>
> Call it as you may.  Whether some style violates more sections of the
> CodingStyle than exist in written form or it hurts the taste of 99% of
> all developers ever having to tough it, my short form for that is "bad
> style".
>
> Point remains, there is a lot of "bad style" and inconsistency in the
> kernel.  But fixing all of it and keeping it fixed would result in a
> lot of work and maybe a couple of device drivers less.  For what gain?

If you try to define a bad/horrible "whatever" in an *absolute* way you
need either the *absolutely* unanimous consent or you need to prove it
using a logical combination of already proven absolute concepts. Since you
missing both of these requirements you cannot say that something is
bad/wrong in an absolute way. You can say though that something is
wrong/bad when dropped inside a given context, and a coding standard might
work as an example. If you try to approach a developer by saying that he
has to use ABC coding standard because it is better that his XYZ coding
standard you're just wrong and you'll have hard time to have him to
understand why he has to use the suggested standard when coding inside the
project JKL. The coding standard gives you the *rule* to define something
wrong when seen inside a given context, since your personal judgement does
not really matter here.



- Davide

