Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263800AbTJET46 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 15:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263822AbTJET45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 15:56:57 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:24980 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S263800AbTJET44 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 15:56:56 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16256.30597.987785.626152@gargle.gargle.HOWL>
Date: Sun, 5 Oct 2003 21:56:53 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: trelane@digitasaru.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Lockup when switching from X to a VC (or when X goes away) in 2.6.0-test6-bk6
In-Reply-To: <20031005193136.GB3445@digitasaru.net>
References: <20031005193136.GB3445@digitasaru.net>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joseph Pingenot writes:
 > There is a curious lockup that happens when I switch from X to a VC or when
 >   exiting X.
 > The whole system hangs; no Magic SysRq keys have any effect (as observed on
 >   screen and by watching the disk activity light).  No oops is printed to
 >   screen that I can see.
 > What should I do to trace this further?  Or is it known (I couldn't find it
 >   looking at the list archives)?

I have a hunch, but your message gives almost no relevant information.
Post your .config and dmesg log.
