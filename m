Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992686AbWJTSfG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992686AbWJTSfG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 14:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992682AbWJTSfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 14:35:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18103 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S2992516AbWJTSfB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 14:35:01 -0400
Date: Fri, 20 Oct 2006 11:31:31 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [0/3] 2.6.19-rc2: known regressions
In-Reply-To: <20061020180722.GA8894@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0610201130590.3962@g5.osdl.org>
References: <Pine.LNX.4.64.0610130941550.3952@g5.osdl.org>
 <20061014111458.GI30596@stusta.de> <20061015122453.GA12549@flint.arm.linux.org.uk>
 <20061015124210.GX30596@stusta.de> <20061019081753.GA29883@flint.arm.linux.org.uk>
 <20061020180722.GA8894@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 20 Oct 2006, Russell King wrote:
> 
> Since everyone seems intent at ignoring this issue, here's a patch to
> try to solve it.

Heh. I just merged another one (through Andrew), so it _should_ be fixed 
in my tree already. But thanks,

		Linus
