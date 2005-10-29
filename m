Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932701AbVJ2W3b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932701AbVJ2W3b (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 18:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932696AbVJ2W3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 18:29:31 -0400
Received: from ns2.suse.de ([195.135.220.15]:10399 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932701AbVJ2W3a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 18:29:30 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Tony Luck <tony.luck@gmail.com>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: New (now current development process)
References: <4d8e3fd30510291026x611aa715pc1a153e706e70bc2@mail.gmail.com>
	<12c511ca0510291157u5557b6b1x85a47311f0e16436@mail.gmail.com>
	<20051029195115.GD14039@flint.arm.linux.org.uk>
	<Pine.LNX.4.64.0510291314100.3348@g5.osdl.org>
From: Andi Kleen <ak@suse.de>
Date: 30 Oct 2005 00:29:28 +0200
In-Reply-To: <Pine.LNX.4.64.0510291314100.3348@g5.osdl.org>
Message-ID: <p73r7a4t0s7.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:
> 
> But to hit that, we'd might need to shrink the "merge window" from two 
> weeks to just one, otherwise there's not enough time to calm down. With 

Please don't. Even the two weeks are too short IMHO, because it is
hard to digest so much code in such a short time and also it is not
always easy for maintainers to hit such short time windows for sending
patches.

> I don't think anybody has been really unhappy with this approach? Hmm?

The long freeze periods were nothing much happens are painful. It
would be better to have some more overlap of merging and stabilizing
(stable does that already kind of, but not enough)

-Andi
