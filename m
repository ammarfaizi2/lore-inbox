Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264942AbTL2UQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 15:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265112AbTL2UQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 15:16:59 -0500
Received: from fw.osdl.org ([65.172.181.6]:446 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264942AbTL2UPh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 15:15:37 -0500
Date: Mon, 29 Dec 2003 12:15:16 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Daniel Phillips <phillips@arcor.de>
cc: William Lee Irwin III <wli@holomorphy.com>, mfedyk@matchmail.com,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Anton Ertl <anton@mips.complang.tuwien.ac.at>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Subpages (was: Page Colouring)
In-Reply-To: <200312291501.32541.phillips@arcor.de>
Message-ID: <Pine.LNX.4.58.0312291214030.2113@home.osdl.org>
References: <179fV-1iK-23@gated-at.bofh.it> <20031229025507.GT22443@holomorphy.com>
 <Pine.LNX.4.58.0312282000390.11299@home.osdl.org> <200312291501.32541.phillips@arcor.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 29 Dec 2003, Daniel Phillips wrote:
> 
> I took a stab at implementing subpages some time ago in 2.4 and got it mostly 
> working but not quite bootable.  I did find out roughly how invasive the 
> patch is, which is: not very, unless I've overlooked something major.  I'll 
> get busy on a 2.6 prototype, and of course I'll listen attentively for 
> reasons why this plan won't work.

Ah, ok. I thought it was further along than that.

If so, let's consider that possibility a more long-range plan - it is 
independent of just making PAGE_CACHE_SIZE be bigger.

		Linus
