Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264358AbTL3Cqw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 21:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264361AbTL3Cqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 21:46:52 -0500
Received: from [24.35.117.106] ([24.35.117.106]:33931 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S264358AbTL3Cqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 21:46:51 -0500
Date: Mon, 29 Dec 2003 21:46:45 -0500 (EST)
From: Thomas Molina <tmolina@cablespeed.com>
X-X-Sender: tmolina@localhost.localdomain
To: Norman Diamond <ndiamond@wta.att.ne.jp>
cc: dan@eglifamily.dnsalias.net, linux-kernel@vger.kernel.org
Subject: Re: Blank Screen in 2.6.0
In-Reply-To: <00d401c3ce7a$a302fd80$98ee4ca5@DIAMONDLX60>
Message-ID: <Pine.LNX.4.58.0312292137100.6639@localhost.localdomain>
References: <007101c3cdbc$046a58d0$2fee4ca5@DIAMONDLX60>
 <Pine.LNX.4.58.0312291741530.5409@localhost.localdomain>
 <00d401c3ce7a$a302fd80$98ee4ca5@DIAMONDLX60>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 30 Dec 2003, Norman Diamond wrote:

> > I've used RH8, RH9, and  Fedora Core 1 and haven't had a problem with vga=
> > in any of them during the 2.5/2.6 series, right up through the current one.
> 
> I forgot if Dan is using RH8 or RH9.  Whichever, you're getting different
> results than he did, because his failed with one of these and yours works
> with both.  At least my failures with SuSE are consistent.  I'd say the
> overall inconsistency points to a bug in 2.6.0-test* and .0.  Especially
> when no one seems to be reporting similar failures in the 2.4 series.

I've had problems at various times during 2.5 with a number of 
card-specific framebuffer drivers so I've backed off to only using the 
VESA framebuffer driver.  Maybe the connection is which framebuffer driver 
is used.
