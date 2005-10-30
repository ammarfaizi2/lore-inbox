Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932283AbVJ3VYi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbVJ3VYi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 16:24:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932158AbVJ3VXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 16:23:55 -0500
Received: from smtp.osdl.org ([65.172.181.4]:32430 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932150AbVJ3VXv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 16:23:51 -0500
Date: Sun, 30 Oct 2005 11:12:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: ak@suse.de, torvalds@osdl.org, tony.luck@gmail.com,
       paolo.ciarrocchi@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: New (now current development process)
Message-Id: <20051030111241.74c5b1a6.akpm@osdl.org>
In-Reply-To: <20051029223723.GJ14039@flint.arm.linux.org.uk>
References: <4d8e3fd30510291026x611aa715pc1a153e706e70bc2@mail.gmail.com>
	<12c511ca0510291157u5557b6b1x85a47311f0e16436@mail.gmail.com>
	<20051029195115.GD14039@flint.arm.linux.org.uk>
	<Pine.LNX.4.64.0510291314100.3348@g5.osdl.org>
	<p73r7a4t0s7.fsf@verdi.suse.de>
	<20051029223723.GJ14039@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:
>
> On Sun, Oct 30, 2005 at 12:29:28AM +0200, Andi Kleen wrote:
> > Linus Torvalds <torvalds@osdl.org> writes:
> > > I don't think anybody has been really unhappy with this approach? Hmm?
> > 
> > The long freeze periods were nothing much happens are painful. It
> > would be better to have some more overlap of merging and stabilizing
> > (stable does that already kind of, but not enough)
> 
> Violently agree.  I find the long freeze periods painful and very very
> very boring, to the point of looking for other stuff to do (such as
> cleaning up bits of the kernel and queuing mega-patches for the next
> round of merging.)

The freezes are for fixing bugs, especially recent regressions.  There's no
shortage of them, you know.

I you can think of a better way to get kernel developers off their butts
and actually fixing bugs, I'm all ears.
