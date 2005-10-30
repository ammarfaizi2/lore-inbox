Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932089AbVJ3Vc2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbVJ3Vc2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 16:32:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932105AbVJ3Vc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 16:32:28 -0500
Received: from thunk.org ([69.25.196.29]:10377 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932089AbVJ3Vc2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 16:32:28 -0500
Date: Sun, 30 Oct 2005 16:32:21 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andi Kleen <ak@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Tony Luck <tony.luck@gmail.com>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: New (now current development process)
Message-ID: <20051030213221.GA28020@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>, Andi Kleen <ak@suse.de>,
	Linus Torvalds <torvalds@osdl.org>, Tony Luck <tony.luck@gmail.com>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <4d8e3fd30510291026x611aa715pc1a153e706e70bc2@mail.gmail.com> <12c511ca0510291157u5557b6b1x85a47311f0e16436@mail.gmail.com> <20051029195115.GD14039@flint.arm.linux.org.uk> <Pine.LNX.4.64.0510291314100.3348@g5.osdl.org> <p73r7a4t0s7.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73r7a4t0s7.fsf@verdi.suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 30, 2005 at 12:29:28AM +0200, Andi Kleen wrote:
> Please don't. Even the two weeks are too short IMHO, because it is
> hard to digest so much code in such a short time and also it is not
> always easy for maintainers to hit such short time windows for sending
> patches.
> 
> > I don't think anybody has been really unhappy with this approach? Hmm?
> 
> The long freeze periods were nothing much happens are painful. It
> would be better to have some more overlap of merging and stabilizing
> (stable does that already kind of, but not enough)

I thought Andrew was accepting patches targeted at 2.6.n+1 into the
-mm tree during the freeze periods, yes?  If so, why would it be a
case of "nothing much happens"?  Nothing much might be happening in
Linus's git tree, but that doesn't that they can't be happening in
Andrew's -mm patchsets....

						- Ted
