Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268100AbRIKNvG>; Tue, 11 Sep 2001 09:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268017AbRIKNu4>; Tue, 11 Sep 2001 09:50:56 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:26688 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S268100AbRIKNun>; Tue, 11 Sep 2001 09:50:43 -0400
Date: Tue, 11 Sep 2001 15:49:19 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dipankar Sarma <dipankar@in.ibm.com>, hch@caldera.de,
        linux-kernel@vger.kernel.org, Paul Mckenney <paul.mckenney@us.ibm.com>
Subject: Re: 2.4.10pre7aa1
Message-ID: <20010911154919.Z715@athlon.random>
In-Reply-To: <20010911130430.L715@athlon.random> <E15gmqD-0002YK-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15gmqD-0002YK-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Sep 11, 2001 at 01:40:37PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2001 at 01:40:37PM +0100, Alan Cox wrote:
> > BTW, I fixed a few more issues in the rcu patch (grep for
> > down_interruptible for instance), here an updated patch (will be
> > included in 2.4.10pre8aa1 [or later -aa]) with the name of rcu-2.
> 
> I've been made aware of one other isue with the RCU patch
> US Patent #05442758
> 
> In the absence of an actual real signed header paper patent use grant for GPL 
> usage from the Sequent folks that seems to be rather hard to fix.

many thanks for the info. Since I live in Italy I should be safe to use
it and to contribute the developement until Sequent/IBM fixes the legal
problem. As far I can tell it's quite obviously just a theorical problem
but it was very worth noticing.

Andrea
