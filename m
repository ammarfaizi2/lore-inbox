Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030457AbVJFAUT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030457AbVJFAUT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 20:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030459AbVJFAUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 20:20:19 -0400
Received: from mail21.bluewin.ch ([195.186.18.66]:19634 "EHLO
	mail21.bluewin.ch") by vger.kernel.org with ESMTP id S1030457AbVJFAUS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 20:20:18 -0400
Date: Wed, 5 Oct 2005 20:09:27 -0400
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] small cleanup for kernel/printk.c - CodingStyle, Whitespace, printk() loglevels...
Message-ID: <20051006000927.GA5463@mars>
References: <200510052356.49823.jesper.juhl@gmail.com> <20051005220900.GA2559@mars> <9a8748490510051641m11f554efn5ef13e4fdecbc442@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490510051641m11f554efn5ef13e4fdecbc442@mail.gmail.com>
User-Agent: Mutt/1.5.9i
From: a.othieno@bluewin.ch (Arthur Othieno)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2005 at 01:41:53AM +0200, Jesper Juhl wrote:
> On 10/6/05, Arthur Othieno <a.othieno@bluewin.ch> wrote:
> > On Wed, Oct 05, 2005 at 11:56:49PM +0200, Jesper Juhl wrote:

[ snip ]

> > > -        struct console *a,*b;
> > > +        struct console *a, *b;
> > >       int res = 1;
> >
> > Beep! :)
> >
> huh?

That particular line (struct console *a, *b;) remains indented 8 spaces,
unlike the surrounding code..

		Arthur
