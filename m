Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270418AbRHMS6Z>; Mon, 13 Aug 2001 14:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270408AbRHMS6P>; Mon, 13 Aug 2001 14:58:15 -0400
Received: from smtpsrv0.isis.unc.edu ([152.2.1.139]:13552 "EHLO
	smtpsrv0.isis.unc.edu") by vger.kernel.org with ESMTP
	id <S270422AbRHMS57>; Mon, 13 Aug 2001 14:57:59 -0400
Date: Mon, 13 Aug 2001 14:58:04 -0400 (EDT)
From: "Daniel T. Chen" <crimsun@email.unc.edu>
To: "Ryan C. Bonham" <Ryan@srfarms.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: RE: Hang problem on Tyan K7 Thunder resolved -- SB Live! heads-up
In-Reply-To: <19AB8F9FA07FB0409732402B4817D75A038A5F@FILESERVER.SRF.srfarms.com>
Message-ID: <Pine.A41.4.21L1.0108131452280.51762-100000@login3.isis.unc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Or... you could use Alan's -ac patches with CVS checkouts from
opensource.creative.com, the "best of all 2.4 with sblive
worlds." ;) Coincidentally, this appeared earlier today:
-- snip --
Module name:    emu10k1
Changes by:     rsousa  01/08/13 07:42:32

Modified files:
        .              : audio.c 

Log message:
Corrected tasklet cleanup.
-- snip --

---
Dan Chen                 crimsun@email.unc.edu
GPG key: www.cs.unc.edu/~chenda/pubkey.gpg.asc

On Mon, 13 Aug 2001, Ryan C. Bonham wrote:

> So my basic question is; Alan, can you leave the new sound driver in your AC
> kernels? Your kernels are great, and I would love to run them with the new
> driver, even if it means I have to find some problems... 

