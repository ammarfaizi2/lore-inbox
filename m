Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261771AbTJ1VNo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 16:13:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261772AbTJ1VNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 16:13:44 -0500
Received: from ns.suse.de ([195.135.220.2]:51920 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261771AbTJ1VNn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 16:13:43 -0500
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [pm] fix time after suspend-to-*
References: <Pine.LNX.4.44.0310271535160.13116-100000@cherise>
	<1067329994.861.3.camel@teapot.felipe-alfaro.com>
	<20031028093233.GA1253@elf.ucw.cz>
	<1067351431.1358.11.camel@teapot.felipe-alfaro.com>
	<20031028172818.GB2307@elf.ucw.cz>
	<1067372182.864.11.camel@teapot.felipe-alfaro.com>
From: Andreas Schwab <schwab@suse.de>
X-Yow: This PIZZA symbolizes my COMPLETE EMOTIONAL RECOVERY!!
Date: Tue, 28 Oct 2003 22:13:41 +0100
In-Reply-To: <1067372182.864.11.camel@teapot.felipe-alfaro.com> (Felipe
 Alfaro Solana's message of "Tue, 28 Oct 2003 21:16:23 +0100")
Message-ID: <jewuapoyka.fsf@sykes.suse.de>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> writes:

> Does "gettimeofday()" have into account the effect of adjusting the time
> twice a year, once to make time roll forward one hour and another one to
> roll it back?

There's no such thing in UTC.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
