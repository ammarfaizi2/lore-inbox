Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265768AbUHWBfu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265768AbUHWBfu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 21:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265805AbUHWBfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 21:35:50 -0400
Received: from gate.crashing.org ([63.228.1.57]:6815 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265768AbUHWBfs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 21:35:48 -0400
Subject: Re: [PATCH] ppc32 use simplified mmenonics
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: tab@snarc.org, linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <1093135526.5759.2513.camel@cube>
References: <1093135526.5759.2513.camel@cube>
Content-Type: text/plain
Message-Id: <1093224281.9537.279.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 23 Aug 2004 11:24:42 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I'd rather you went the other way, replacing these
> barely-documented instructions with ones that are
> easy to look up. Motorola has about a zillion of
> these "simplified" instructions. I guess Motorola
> and IBM were jealous of Intel's CISC instructions.

It's just simplified mnemonics, not instructions ;)

> The big problem is this:
>         THESE ARE NOT IN THE INDEX!!!!!!

Yah, that sucks, I tend to agree... I've had a hard time in the
"early days" finding some of them in the manuals

> So, if I forget what one of these many instructions
> does, I'll have quite the time paging through the
> manual trying to find it.
> 
> If it's not in the index, please avoid it.
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

