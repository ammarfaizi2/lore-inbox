Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262796AbTJFH5H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 03:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262805AbTJFH5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 03:57:07 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:21183 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S262796AbTJFH5D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 03:57:03 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16257.8268.470707.664920@gargle.gargle.HOWL>
Date: Mon, 6 Oct 2003 09:57:00 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: trelane@digitasaru.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Lockup when switching from X to a VC (or when X goes away) in 2.6.0-test6-bk6
In-Reply-To: <20031006000659.GD3445@digitasaru.net>
References: <20031005193136.GB3445@digitasaru.net>
	<16256.30597.987785.626152@gargle.gargle.HOWL>
	<20031006000659.GD3445@digitasaru.net>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joseph Pingenot writes:
 > >From Mikael Pettersson on Sunday, 05 October, 2003:
 > >Joseph Pingenot writes:
 > > > There is a curious lockup that happens when I switch from X to a VC or when
 > > >   exiting X.
 > > > The whole system hangs; no Magic SysRq keys have any effect (as observed on
 > > >   screen and by watching the disk activity light).  No oops is printed to
 > > >   screen that I can see.
 > > > What should I do to trace this further?  Or is it known (I couldn't find it
 > > >   looking at the list archives)?
 > >I have a hunch, but your message gives almost no relevant information.
 > >Post your .config and dmesg log.
 > 
 > My apologies if I posted inadequate info; my impression was that people
 >   were more annoyed by posted .configs than helped.
 > Looking over the logs again, the following came up:

Your dmesg log is incomplete.

Your .config provided half confirmation for my hunch, but I
need the complete boot dmesg log to confirm the other half.
