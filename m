Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932707AbVJ2Wha@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932707AbVJ2Wha (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 18:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932709AbVJ2Wha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 18:37:30 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:11535 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932707AbVJ2Wha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 18:37:30 -0400
Date: Sat, 29 Oct 2005 23:37:24 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Tony Luck <tony.luck@gmail.com>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: New (now current development process)
Message-ID: <20051029223723.GJ14039@flint.arm.linux.org.uk>
Mail-Followup-To: Andi Kleen <ak@suse.de>,
	Linus Torvalds <torvalds@osdl.org>, Tony Luck <tony.luck@gmail.com>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <4d8e3fd30510291026x611aa715pc1a153e706e70bc2@mail.gmail.com> <12c511ca0510291157u5557b6b1x85a47311f0e16436@mail.gmail.com> <20051029195115.GD14039@flint.arm.linux.org.uk> <Pine.LNX.4.64.0510291314100.3348@g5.osdl.org> <p73r7a4t0s7.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73r7a4t0s7.fsf@verdi.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 30, 2005 at 12:29:28AM +0200, Andi Kleen wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
> > I don't think anybody has been really unhappy with this approach? Hmm?
> 
> The long freeze periods were nothing much happens are painful. It
> would be better to have some more overlap of merging and stabilizing
> (stable does that already kind of, but not enough)

Violently agree.  I find the long freeze periods painful and very very
very boring, to the point of looking for other stuff to do (such as
cleaning up bits of the kernel and queuing mega-patches for the next
round of merging.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
