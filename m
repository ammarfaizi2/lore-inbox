Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264119AbTLENvW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 08:51:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264126AbTLENvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 08:51:22 -0500
Received: from chaos.analogic.com ([204.178.40.224]:56449 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264119AbTLENvS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 08:51:18 -0500
Date: Fri, 5 Dec 2003 08:52:57 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Nick Piggin <piggin@cyberone.com.au>
cc: Paul Adams <padamsdev@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause?
In-Reply-To: <3FCFCC3E.8050008@cyberone.com.au>
Message-ID: <Pine.LNX.4.53.0312050831370.14820@chaos>
References: <20031204235055.62846.qmail@web21503.mail.yahoo.com>
 <3FCFCC3E.8050008@cyberone.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Dec 2003, Nick Piggin wrote:

>
>
> Paul Adams wrote:
>
> >--- In linux-kernel@yahoogroups.com, Linus Torvalds
> ><torvalds@o...> wrote:
> >
> >>- anything that was written with Linux in mind
> >>
> >(whether it then
> >
> >>_also_ works on other operating systems or not) is
> >>
> >clearly
> >
> >>partially a derived work.
> >>
> >
> >I am no more a lawyer than you are, but I have to
> >disagree.  You
> >are not free to define "derivative work" as you
> >please.  You
> >must use accepted legal definitions.  At least in the
> >U.S., you
> >must consider what Congress had to say on this.  They
> >said, "to
> >constitute a violation of section 106(2) [which gives
> >copyright
> >owners rights over derivative works], the infringing
> >work must
> >incorporate a portion of the copyrighted work in some
> >form; for
> >example, a detailed commentary on a work or a
> >programmatic musical
> >composition inspired by a novel would not normally
> >constitute
> >infringements under this clause."
> >http://www4.law.cornell.edu/uscode/17/106.notes.html
> >
> >A work that is inspired by Linux is no more a
> >derivative work than
> >a programmatic musical composition inspired by a
> >novel.  Having
> >Linux in mind cannot be enough to constitute
> >infringement.
> >
>
> Of course not, thought police aren't any good until a mind reader
> is invented ;)
>
> Seriously:
> What about specifically a module that includes the Linux Kernel's
> headers and uses its APIs? I don't think you could say that is
> definitely not a derivative work.
>

When copyright law was developed, nobody thought of
"#include <filename.h>".

Let's guess what that means. To me, that is like a reference
to a written work, when you attribute something to some document
that was previously written and, incidentally, give appropriate
credit to the writer(s). In this context, it is clearly not
a copyright infringement to include the works of others with
appropriate credit being given.

It is just like; "See John Smith's article on frogs", referenced
in an article about frogs.

However, there are some who would claim that they don't want
their previous work referenced by others at all, in particular
those who might dirty their hands by making money with it.

The only known way to prevent others from referencing a previous
work is to not publish it at all. "Publish means to make public".
If you don't want others referencing your precious work, then
you need to keep it secret. It's just that simple. You can't have
it both ways. You can't say, "I publish this only for the eyes of
my friends who will work for free."

Now, I have seen some who write their own header files because
they think that including somebody else's creation might violate
some copyright law. This, in fact, might be a violation in
itself, to incorporate "whole cloth" the works of others in
a separate document does appear to violate US law. However,
referencing the unmodified original document, clearly
(as clear are any law could be interpreted) does not.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


