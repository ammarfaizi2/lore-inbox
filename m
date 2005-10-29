Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751220AbVJ2QYf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbVJ2QYf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 12:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbVJ2QYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 12:24:35 -0400
Received: from fattire.cabal.ca ([134.117.69.58]:43414 "EHLO fattire.cabal.ca")
	by vger.kernel.org with ESMTP id S1751220AbVJ2QYe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 12:24:34 -0400
X-IMAP-Sender: kyle
Date: Sat, 29 Oct 2005 12:23:59 -0400
X-OfflineIMAP-98645241-52656d6f746546617454697265-494e424f582e4f7574626f78: 1130603071-0622317585337-v4.0.11
From: Kyle McMartin <kyle@mcmartin.ca>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: ominous git commit
Message-ID: <20051029162359.GA2709@tachyon.int.mcmartin.ca>
References: <Pine.LNX.4.61.0510290017460.20152@gans.physik3.uni-rostock.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0510290017460.20152@gans.physik3.uni-rostock.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2005 at 12:24:27AM +0200, Tim Schmielau wrote:
> It's commit message says: 'Auto-update from upstream', and it indeed seems 
> to contain changes already made to the upstream tree. Would someone please 
> explain to me why it shows up in Linus' tree?
>

If you look around the shortlog, you'll see I'm not the only person[1] with
these messages. I suspect mine was large because I pulled my linus branch
into my parisc branch, rather than vice versa. Linus explained to me that
these merge markers get created whenever a non-trivial merge occurs.
Not something to worry about, I believe. 

Cheers,
	Kyle

1: http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=6fbfddcb52d8d9fa2cd209f5ac2a1c87497d55b5
