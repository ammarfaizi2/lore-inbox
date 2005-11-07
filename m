Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964841AbVKGQNG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964841AbVKGQNG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 11:13:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964842AbVKGQNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 11:13:05 -0500
Received: from khc.piap.pl ([195.187.100.11]:5124 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S964841AbVKGQNE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 11:13:04 -0500
To: Eric Sandall <eric@sandall.us>
Cc: Willy Tarreau <willy@w.ods.org>, Linus Torvalds <torvalds@osdl.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Tony Luck <tony.luck@gmail.com>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: New (now current development process)
References: <4d8e3fd30510291026x611aa715pc1a153e706e70bc2@mail.gmail.com>
	<12c511ca0510291157u5557b6b1x85a47311f0e16436@mail.gmail.com>
	<20051029195115.GD14039@flint.arm.linux.org.uk>
	<Pine.LNX.4.64.0510291314100.3348@g5.osdl.org>
	<20051031064109.GO22601@alpha.home.local>
	<Pine.LNX.4.63.0511062052590.24477@cerberus>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Mon, 07 Nov 2005 17:12:57 +0100
In-Reply-To: <Pine.LNX.4.63.0511062052590.24477@cerberus> (Eric Sandall's
 message of "Sun, 6 Nov 2005 20:54:30 -0800 (PST)")
Message-ID: <m3k6fkxwqe.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Sandall <eric@sandall.us> writes:

> A -final should never be changed from the last -rc. That defeats the
> purpose of having -rc releases (rc == 'release candidate' ;)).

This logic is flawed. RCs are for performing tests. If you don't want
further tests (for example, tests on previous RC completed and you're
quite sure new changes introduce no new bugs) you don't need further
RCs.
-- 
Krzysztof Halasa
