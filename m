Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264948AbUFGRko@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264948AbUFGRko (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 13:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264949AbUFGRko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 13:40:44 -0400
Received: from zero.aec.at ([193.170.194.10]:16900 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S264948AbUFGRkn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 13:40:43 -0400
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: WINE + NX (No eXecute) support for x86, 2.6.7-rc2-bk2
References: <23Y4Y-6F5-1@gated-at.bofh.it> <240qb-8ir-7@gated-at.bofh.it>
	<240Tc-gV-5@gated-at.bofh.it> <2412S-pU-3@gated-at.bofh.it>
	<24vX0-81P-7@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Mon, 07 Jun 2004 19:40:37 +0200
In-Reply-To: <24vX0-81P-7@gated-at.bofh.it> (Ingo Molnar's message of "Mon,
 07 Jun 2004 19:20:06 +0200")
Message-ID: <m3brjv2rmy.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:
>
> Wine is in a really difficult position (due to the complex task it
> achieves) and is more sensitive to VM layout changes than other
> applications. So lets try to find the solution that preserves the

More ELF headers bits are not really hard to add.

-Andi

