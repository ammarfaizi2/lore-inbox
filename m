Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268158AbUGWXNk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268158AbUGWXNk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 19:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268169AbUGWXNk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 19:13:40 -0400
Received: from cantor.suse.de ([195.135.220.2]:17103 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268158AbUGWXNi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 19:13:38 -0400
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hlist_for_each_safe cleanup
References: <20040723140527.7e3c119a@dell_ss3.pdx.osdl.net>
	<jeoem65shc.fsf@sykes.suse.de>
	<20040723155614.2a63dc71@dell_ss3.pdx.osdl.net>
From: Andreas Schwab <schwab@suse.de>
X-Yow: Now I'm being INVOLUNTARILY shuffled closer to the CLAM DIP
 with the BROKEN PLASTIC FORKS in it!!
Date: Sat, 24 Jul 2004 01:13:37 +0200
In-Reply-To: <20040723155614.2a63dc71@dell_ss3.pdx.osdl.net> (Stephen
 Hemminger's message of "Fri, 23 Jul 2004 15:56:14 -0700")
Message-ID: <jek6wu5nby.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger <shemminger@osdl.org> writes:

> What's your problem with the gcc extensions, the kernel uses them all over the place,
> planning on starting a conversion?

Why use an extension when an equivalent standard construct exists that is
no less readable?

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
