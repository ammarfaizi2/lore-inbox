Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261289AbULNPwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261289AbULNPwY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 10:52:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbULNPwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 10:52:24 -0500
Received: from fw.osdl.org ([65.172.181.6]:63142 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261289AbULNPwX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 10:52:23 -0500
Date: Tue, 14 Dec 2004 07:52:06 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Harald Welte <laforge@netfilter.org>
cc: Andries Brouwer <aebr@win.tue.nl>, Patrick McHardy <kaber@trash.net>,
       akpm@osdl.org, Andries Brouwer <Andries.Brouwer@cwi.nl>,
       coreteam@netfilter.org, linux-kernel@vger.kernel.org,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [netfilter-core] [PATCH] no __initdata in netfilter?
In-Reply-To: <20041214130041.GU22577@sunbeam.de.gnumonks.org>
Message-ID: <Pine.LNX.4.58.0412140750230.3279@ppc970.osdl.org>
References: <20041114013724.GA21219@apps.cwi.nl> <41970FAD.6010501@trash.net>
 <20041114112610.GB8680@pclin040.win.tue.nl> <20041214130041.GU22577@sunbeam.de.gnumonks.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 14 Dec 2004, Harald Welte wrote:
> 
> Pleaes pull out that change again and submit one that adds a comment, or
> alternatively pick up the (incremental) change attached to this mail.  I
> hope this makes your checker not spit any warnings.

You guys are the ones that should do the work, and go through the proper 
channels. Do the comment, and go through Davem etc. I personally think 
that Andries' patch did the right thing, but hey, whatever. But asking 
_him_ to do something he disagrees with is just silly.

		Linus
