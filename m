Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264601AbTLEXMG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 18:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264604AbTLEXMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 18:12:05 -0500
Received: from fw.osdl.org ([65.172.181.6]:37081 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264601AbTLEXL6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 18:11:58 -0500
Date: Fri, 5 Dec 2003 15:11:56 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: gary ng <garyng2000@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause?
In-Reply-To: <20031205224345.13710.qmail@web11502.mail.yahoo.com>
Message-ID: <Pine.LNX.4.58.0312051504230.9125@home.osdl.org>
References: <20031205224345.13710.qmail@web11502.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 5 Dec 2003, gary ng wrote:
>
> As the copyright holder, you definitely have the right
> to staple restrictions on derivative works. However, I
> would say your idea(if I interpet them correctly) of
> derivative work is a bit broad.

Ahhah! But that's how these things work. Everybody wants more than they
may be entitled to, and you don't concede a thing.

Until somebody comes up with a good counter-argument, at which point you
say "Yes, that is ok".

And I'd like to point out that this is exactly how we _do_ work. This is
why certain binary-only modules are accepted: we're bitching and moaning
about how hard those nvidia-caused problems are to debug, but we're not
actually suing nvidia.

See? The basic _assumption_ is that all modules are derived works. But
once you get to specifics, the answer may well be "oh, in your case you
can show preexisting work on other operating systems, and you have a good
case that your code isn't actually derived from the kernel, so as long as
you realize that we'll never be able to support or care about your module,
we won't bother you".

It's a bit like haggling. You ask for the world ("I'll let you have that
camel for a thousand dinars _and_ your first-born"), and you listen to the
counter-arguments ("but that camel looks a bit diseased, and is blind in
one eye"), and maybe you settle it amicably ("ok, how about we trade you
that goat"), or maybe you don't. And if somebody ends up stealing your
camel rather than settling your differences, you might have to go to court
("cut off his hands").

		Linus
